using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CourseManagement.Presenters.ViewInterface;
using CourseManagement.Model;

namespace CourseManagement.Presenters
{
    public class CoursePresenter
    {
        private readonly IViewCourse _viewCourse;
        public CoursePresenter(IViewCourse viewCourse)
        {
            _viewCourse = viewCourse;
        }

        public void GetCourses()
        {
            var courseModel = new CourseModel();
            _viewCourse.CourseList = courseModel.GetCourses();
        }

        public void DeleteCourse()
        {
            var courseModel = new CourseModel();
            courseModel.DeleteCourse(_viewCourse.Course.CourseId);
        }

        public void AddCourse()
        {
            var courseModel = new CourseModel();
            courseModel.AddCourse(_viewCourse.Course);
        }

        public void EditCourse()
        {
            var courseModel = new CourseModel();
            courseModel.EditCourse(_viewCourse.Course);
        }

        public void GetCourseDetails()
        {
            var courseModel = new CourseModel();
           _viewCourse.Course = courseModel.GetCourseDetails(_viewCourse.Course.CourseId);
        }
    }
}
