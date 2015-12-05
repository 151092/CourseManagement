using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CourseManagement.Entity
{
    public class Course : EntityBase
    {
        public int CourseId { get; set; }
        public string CourseName { get; set; }
        public decimal CourseDuration { get; set; }
        public int CourseFees { get; set; }
    }
}
