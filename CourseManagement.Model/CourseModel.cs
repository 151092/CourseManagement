using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CourseManagement.Entity;
using CourseManagement.Model.Data;

namespace CourseManagement.Model
{
    public class CourseModel
    {
        public List<Course> GetCourses()
        {
            List<Course> courseList = new List<Course>();
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                courseList = context.CourseMasters.Where(c => !c.IsDeleted).Select(c => new Course
                {
                    CourseId = c.CourseId,
                    CourseDuration = c.CourseDuration,
                    CourseFees = c.CourseFees,
                    CourseName = c.CourseName
                }).ToList();
            }
            return courseList;
        }

        public void DeleteCourse(int courseId)
        {
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {

                var course = context.CourseMasters.Where(c => c.CourseId == courseId && !c.IsDeleted).FirstOrDefault();
                course.IsDeleted = true;
                DeleteStudentCourseRef(courseId);
                context.SubmitChanges();
            }
        }

        public void AddCourse(Course course)
        {
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                CourseMaster courseMaster = new CourseMaster();
                courseMaster.CourseName = course.CourseName;
                courseMaster.CourseDuration = course.CourseDuration;
                courseMaster.CourseFees = course.CourseFees;
                courseMaster.IsDeleted = false;
                context.CourseMasters.InsertOnSubmit(courseMaster);
                context.SubmitChanges();
            }
        }

        public void EditCourse(Course course)
        {
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                CourseMaster courseMaster = context.CourseMasters.Where(c => c.CourseId == course.CourseId && !c.IsDeleted).FirstOrDefault();
                courseMaster.CourseName = course.CourseName;
                courseMaster.CourseDuration = course.CourseDuration;
                courseMaster.CourseFees = course.CourseFees;
                context.SubmitChanges();
            }
        }

        public Course GetCourseDetails(int courseId)
        {
            Course course = new Course();
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                course = context.CourseMasters.Where(c => c.CourseId == courseId && !c.IsDeleted).Select(c => new Course
                {
                    CourseId = c.CourseId,
                    CourseDuration = c.CourseDuration,
                    CourseFees = c.CourseFees,
                    CourseName = c.CourseName
                }).FirstOrDefault();
            }
            return course;
        }

        public void DeleteStudentCourseRef(int courseId)
        {
            using (CourseManagementDBDataContext context = new CourseManagementDBDataContext())
            {
                var list = context.CourseStudentRefs.Where(c => !c.IsDeleted && c.CourseId == courseId).ToList();
                foreach (var item in list)
                {
                    item.IsDeleted = true;
                }
                context.SubmitChanges();
            }

        }
    }
}
