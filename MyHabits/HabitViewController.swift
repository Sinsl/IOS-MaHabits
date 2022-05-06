//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Mac Home on 06.05.2022.
//

import UIKit

class HabitViewController: UIViewController {
    
    weak var delegateHabits: HabitsViewController?
    weak var delegateDetail: HabitDetailsViewController?
    
    var habit: Habit? = nil
    
    private var textNameHabit: String = ""
    private var timeText: String = "11:00 PM"
    private var date: Date = Date()
    private var color = UIColor.blue
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
       return view
   }()
    
    private let labelNameHabil: UILabel = {
        let label  = UILabel()
        label.text = "Название"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.text = label.text?.uppercased()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var textFieldNameHabit: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, спать по 8 часов и т.д."
        textField.text = textNameHabit
        textField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        textField.textColor = AppColor(color: .blue)
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.addTarget(self, action: #selector(setNameHabit), for: UIControl.Event.editingDidEndOnExit)
        return textField
    }()

    private let labelColor: UILabel = {
        let label  = UILabel()
        label.text = "Цвет"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.text = label.text?.uppercased()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = self.color
        return view
    }()

    private let labelTime: UILabel = {
        let label  = UILabel()
        label.text = "Время"
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.text = label.text?.uppercased()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let labelTextTime: UILabel = {
        let label  = UILabel()
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var textFieldTime: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = self.timeText
        textField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        textField.textColor = AppColor(color: .purple)
        textField.backgroundColor = .white
        textField.layer.masksToBounds = true
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        return textField
    }()

    lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.sizeToFit()
        picker.addTarget(self, action: #selector(setTime), for: UIControl.Event.valueChanged)

        return picker
    }()
    
    lazy var buttonDelete: UIButton = {
       let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.contentVerticalAlignment = .top
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private let device = UIDevice.current.userInterfaceIdiom.rawValue

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setValue()
        setNavBar()
        setLayout()
    }
    
    private func setValue(){
        if habit != nil {
            textNameHabit = habit!.name
            timeText = habit!.dateString
            date = habit!.date
            color = habit!.color
        }
    }
    
    private func setNavBar() {
        let cancel = UIBarButtonItem(title: "Отменить", style: .done, target: self, action: #selector(cancelButton))
        navigationItem.leftBarButtonItem = cancel
        cancel.tintColor = AppColor(color: .purple)
        let save = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButton))
        navigationItem.rightBarButtonItem = save
        save.tintColor = AppColor(color: .purple)
    }
    
    @objc func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButton() {
        let newHabit = Habit(name: textNameHabit,
                             date: self.date,
                             color: self.color)
        var indexItem: Int? = nil
        if habit != nil {
            indexItem = find(value: habit!)
            HabitsStore.shared.habits[indexItem!].name = newHabit.name
            HabitsStore.shared.habits[indexItem!].date = newHabit.date
            HabitsStore.shared.habits[indexItem!].color = newHabit.color
            delegateDetail?.update(text: "Saved")
        } else {
            HabitsStore.shared.habits.append(newHabit)
            delegateHabits?.update(text: "Create")
        }
        self.dismiss(animated: true, completion: nil)
    }

    @objc func setNameHabit() {
        if textFieldNameHabit.text == "" {
            textNameHabit = "Название не введено"
        } else {
            textNameHabit = textFieldNameHabit.text!
        }
        textFieldNameHabit.resignFirstResponder()
    }
    
    @objc func buttonPressed() {
        let action = UIAlertController(title: "Удалить привычку?", message: "Вы хотите удалить привычку: \(habit!.name)", preferredStyle: .alert)
        let cansel = UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in } )
        action.addAction(cansel)
        let indexItem = find(value: habit!)
        let delete = UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            HabitsStore.shared.habits.remove(at: indexItem!)
            self.delegateDetail?.update(text: "Delete")
            self.dismiss(animated: true, completion: nil)
                } )
        action.addAction(delete)
        present(action, animated: true, completion: nil)
    }
    
    private func find(value searchValue: Habit) -> Int? {
        for (index, value) in HabitsStore.shared.habits.enumerated() {
            if value == searchValue {
                return index
            }
        }
        return nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setTapGesture()
        setTime()
    }
    
    private func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openColorPicker))
        colorView.addGestureRecognizer(tapGesture)
    }

    @objc private func openColorPicker() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = .orange
        present(picker, animated: true, completion: nil)
    }

    @objc func setTime() {
        let dateformatter = DateFormatter()
        dateformatter.timeStyle = .short
        textFieldTime.text = dateformatter.string(from: timePicker.date)
        self.date = timePicker.date
        timeText = dateformatter.string(from: timePicker.date)
    }
   
    
    private func setLayout() {
        view.addSubview(scrollView)
        view.addSubview(buttonDelete)
        
        var insetButtom: CGFloat = 40
        if device == 1 {
            insetButtom = 70
        }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(baseView)
        
        NSLayoutConstraint.activate([
            baseView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            baseView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            baseView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            baseView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            baseView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [textFieldNameHabit, labelNameHabil, labelColor, colorView, labelTime, labelTextTime, textFieldTime, timePicker].forEach{baseView.addSubview($0)}
        NSLayoutConstraint.activate([
            labelNameHabil.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            labelNameHabil.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 21),
            labelNameHabil.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            textFieldNameHabit.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            textFieldNameHabit.topAnchor.constraint(equalTo: labelNameHabil.bottomAnchor, constant: 7),
            textFieldNameHabit.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16),
            textFieldNameHabit.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            labelColor.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            labelColor.topAnchor.constraint(equalTo: textFieldNameHabit.bottomAnchor, constant: 21),
            labelColor.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            colorView.topAnchor.constraint(equalTo: labelColor.bottomAnchor, constant: 7),
            colorView.widthAnchor.constraint(equalToConstant: 30),
            colorView.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            labelTime.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            labelTime.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 21),
            labelTime.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            labelTextTime.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            labelTextTime.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 7)
        ])
        NSLayoutConstraint.activate([
            textFieldTime.leadingAnchor.constraint(equalTo: labelTextTime.trailingAnchor, constant: 8),
            textFieldTime.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 7),
            textFieldTime.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            timePicker.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: 16),
            timePicker.topAnchor.constraint(equalTo: labelTextTime.bottomAnchor, constant: 10),
            timePicker.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -16),
            timePicker.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: -insetButtom)
        ])
        
        if habit != nil {
            buttonDelete.isHidden = false
            NSLayoutConstraint.activate([
                buttonDelete.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                buttonDelete.heightAnchor.constraint(equalToConstant: insetButtom),
                buttonDelete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                buttonDelete.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            buttonDelete.isHidden = true
        }
    }
    
}
extension HabitViewController: UIColorPickerViewControllerDelegate {
//    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
//    }
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.colorView.backgroundColor = viewController.selectedColor
        self.color = viewController.selectedColor
    }
}
