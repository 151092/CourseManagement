using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CourseManagement.Entity;
using CourseManagement.Model.Data;

namespace CourseManagement.Model
{
    public class StudentModel
    {
        public List<Student> GetStudents()
        {
            List<Student> studentList = new List<Student>();
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                studentList = context.StudentMasters.Where(c => !c.IsDeleted).Select(c => new Student
                {
                    StudentId = c.StudentId,
                    StudentName = c.StudentName,
                    Address = c.Address,
                    Mobile = c.Mobile,
                    Phone = c.Phone
                }).ToList();
            }

            foreach (var item in studentList)
            {
                item.CourseList = GetStudentCourseRef(item.StudentId);
            }
            return studentList;
        }

        public void DeleteStudent(int studentId)
        {
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                var student = context.StudentMasters.Where(c => c.StudentId == studentId && !c.IsDeleted).FirstOrDefault();
                student.IsDeleted = true;
                DeleteStudentCourseRef(studentId);
                context.SubmitChanges();
            }
        }

        public void AddStudent(Student student)
        {
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                StudentMaster studentMaster = new StudentMaster();
                studentMaster.StudentName = student.StudentName;
                studentMaster.Mobile = student.Mobile;
                studentMaster.Phone = student.Phone;
                studentMaster.Address = student.Address;
                studentMaster.IsDeleted = false;
                context.StudentMasters.InsertOnSubmit(studentMaster);
                context.SubmitChanges();
            }
        }

        public void EditStudent(Student student)
        {
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                StudentMaster studentMaster = context.StudentMasters.Where(c => c.StudentId == student.StudentId && !c.IsDeleted).FirstOrDefault();
                studentMaster.StudentName = student.StudentName;
                studentMaster.Mobile = student.Mobile;
                studentMaster.Phone = student.Phone;
                studentMaster.Address = student.Address;
                context.SubmitChanges();
            }
        }

        public Student GetStudentDetails(int studentId)
        {
            Student student = new Student();
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                student = context.StudentMasters.Where(s => s.StudentId == studentId && !s.IsDeleted).Select(s => new Student
                {
                    StudentId = s.StudentId,
                    StudentName = s.StudentName,
                    Mobile = s.Mobile,
                    Phone = s.Phone,
                    Address = s.Address
                }).FirstOrDefault();
            }
            return student;
        }

        public void UpdateStudentCourseRef(int studentId, List<Course> courseList)
        {
            List<Course> oldCourseList = GetStudentCourseRef(studentId);
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                foreach (var item in courseList)
                {
                    bool foundInOld = false;
                    foreach (var old in oldCourseList)
                    {
                        if (item.CourseId == old.CourseId)
                        {
                            foundInOld = true;
                            break;
                        }
                    }
                    if (!foundInOld)
                    {

                        CourseStudentRef courseStudentRef = new CourseStudentRef();
                        courseStudentRef.CourseId = item.CourseId;
                        courseStudentRef.StudentId = studentId;
                        courseStudentRef.IsDeleted = false;
                        context.CourseStudentRefs.InsertOnSubmit(courseStudentRef);
                    }
                }


                foreach (var old in oldCourseList)
                {
                    bool removedInNew = true;
                    foreach (var item in courseList)
                    {
                        if (old.CourseId == item.CourseId)
                        {
                            removedInNew = false;
                            break;
                        }
                    }
                    if (removedInNew)
                    {

                        var courseStudentRef = context.CourseStudentRefs.Where(c => !c.IsDeleted && c.CourseId == old.CourseId && c.StudentId == studentId).FirstOrDefault();
                        courseStudentRef.IsDeleted = true;

                    }

                }

                //Perform database operations only once.
                context.SubmitChanges();
            }
        }

        public List<Course> GetStudentCourseRef(int studentId)
        {
            List<Course> studentCourseList = new List<Course>();
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                studentCourseList = (from cs in context.CourseStudentRefs
                                     join c in context.CourseMasters
                                     on cs.CourseId equals c.CourseId
                                     where cs.StudentId == studentId && !cs.IsDeleted && !c.IsDeleted
                                     select new Course()
                                     {
                                         CourseId = c.CourseId,
                                         CourseName = c.CourseName
                                     }).ToList();
            }
            return studentCourseList;
        }

        public void DeleteStudentCourseRef(int studentId)
        { 
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                var list = context.CourseStudentRefs.Where(c => !c.IsDeleted && c.StudentId == studentId).ToList();
                foreach (var item in list)
                {
                    item.IsDeleted = true;
                }
                context.SubmitChanges();
            }
            
        }
    }
}
