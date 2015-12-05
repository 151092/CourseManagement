using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CourseManagement.Entity
{
    public class Student : EntityBase
    {
        public int StudentId { get; set; }
        public string StudentName { get; set; }
        public string Phone { get; set; }
        public string Mobile { get; set; }
        public string Address { get; set; }
        public List<Course> CourseList { get; set; }
    }
}
