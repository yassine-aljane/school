package tn.m104.rh.service;

import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import tn.m104.rh.entity.Student;
import tn.m104.rh.repository.StudentRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@ExtendWith(MockitoExtension.class)
class StudentServiceImplTest {
    @Mock
    StudentRepository studentRepository;

    @InjectMocks
    StudentServiceImpl studentService ;

    Student student = new Student(1, "name1","adress1", 20.00);
    List<Student> listStudents = new ArrayList<Student>() {
        {
            add(new Student(2, "name2","adress2", 30.00));
            add(new Student(3, "name3","adress3", 10.00));
        }
    };

    // TDD : Test Driven Development : Developpement dirigé par les Tests

    @Test
    @Order(1)
    public void testGetStudents() {

        Mockito.when(studentRepository.findAll()).thenReturn(listStudents);

        List<Student> listU = studentService.getStudents();

        Assertions.assertEquals(2, listU.size());
        Mockito.verify(studentRepository, Mockito.times(1)).findAll();
    }

    @Test
    @Order(2)
    public void testRegisterStudent() {
        // Mock the save operation to return the student object that was passed in
        Mockito.when(studentRepository.save(student)).thenReturn(student);

        // Call the service method
        Student registeredStudent = studentService.registerStudent(student);

        // Verify the result
        Assertions.assertNotNull(registeredStudent);
        Assertions.assertEquals(student.getName(), registeredStudent.getName());

        // Verify that the save method was called exactly once
        Mockito.verify(studentRepository, Mockito.times(1)).save(student);
    }

    @Test
    @Order(3)
    public void testUpdateStudent() {
        // 1. Setup the student to be updated (e.g., student with ID 1)
        Student existingStudent = new Student(1, "OldName", "OldAddress", 50.00);
        Student updatedStudentData = new Student(1, "NewName", "NewAddress", 99.99);

        // 2. Mock findById to return the existing student
        Mockito.when(studentRepository.findById(existingStudent.getRollNumber())).thenReturn(Optional.of(existingStudent));

        // 3. Mock save to return the updated student object
        Mockito.when(studentRepository.save(any(Student.class))).thenReturn(updatedStudentData);

        // 4. Call the service method
        Student result = studentService.updateStudent(updatedStudentData);

        // 5. Verify the result
        Assertions.assertNotNull(result);
        Assertions.assertEquals("NewName", result.getName());
        Assertions.assertEquals(99.99, result.getPercentage());

        // 6. Verify that findById and save were called
        Mockito.verify(studentRepository, Mockito.times(1)).findById(existingStudent.getRollNumber());
        Mockito.verify(studentRepository, Mockito.times(1)).save(any(Student.class));
    }

    @Test
    @Order(4)
    public void testDeleteStudent() {
        // Define the ID of the student to delete
        Integer studentIdToDelete = 1;

        // Call the service method
        studentService.deleteStudent(studentIdToDelete);

        // Verify that the deleteById method was called exactly once with the correct ID
        Mockito.verify(studentRepository, Mockito.times(1)).deleteById(studentIdToDelete);
    }
}
