using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CourseManagement.Model.Data
{
    public partial class CourseManagementDBDataContext
    {
        public CourseManagementDBDataContext() :
            this(System.Configuration.ConfigurationManager.ConnectionStrings["CourseManagement.Model.Properties.Settings.CourseManagementConnectionString"].ConnectionString)
        {
            OnCreated();
        }
    }
}
