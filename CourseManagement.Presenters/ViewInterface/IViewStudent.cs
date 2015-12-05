using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using CourseManagement.Entity;

namespace CourseManagement.Presenters.ViewInterface
{
    public interface IViewStudent
    {
        List<Student> StudentList { get; set; }
        Student Student { get; set; }
    }
}
