using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CourseManagement.Entity;

namespace CourseManagement.Presenters.ViewInterface
{
    public interface IViewCourse
    {
        List<Course> CourseList { get; set; }
        Course Course { get; set; }
    }
}
