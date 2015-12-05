using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CourseManagement.Presenters.ViewInterface;
using CourseManagement.Model;

namespace CourseManagement.Presenters
{
    public class StudentPresenter
    {
        private readonly IViewStudent _viewStudent;
        public StudentPresenter(IViewStudent viewStudent)
        {
            _viewStudent = viewStudent;
        }

        public void GetStudents()
        {
            var studentModel = new StudentModel();
            _viewStudent.StudentList = studentModel.GetStudents();
        }

        public void DeleteStudent()
        {
            var studentModel = new StudentModel();
            studentModel.DeleteStudent(_viewStudent.Student.StudentId);
        }

        public void AddStudent()
        {
            var studentModel = new StudentModel();
            studentModel.AddStudent(_viewStudent.Student);
        }

        public void EditStudent()
        {
            var studentModel = new StudentModel();
            studentModel.EditStudent(_viewStudent.Student);
        }

        public void GetStudentDetails()
        {
            var studentModel = new StudentModel();
            _viewStudent.Student = studentModel.GetStudentDetails(_viewStudent.Student.StudentId);
        }

        public void GetStudentCourseRef()
        {
            var studentModel = new StudentModel();
            _viewStudent.Student.CourseList = studentModel.GetStudentCourseRef(_viewStudent.Student.StudentId);
        }

        public void UpdateStudentCourseRef()
        {
            var studentModel = new StudentModel();
            studentModel.UpdateStudentCourseRef(_viewStudent.Student.StudentId, _viewStudent.Student.CourseList);
        }

    }
}
