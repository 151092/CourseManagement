using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CourseManagement.Presenters.ViewInterface;
using CourseManagement.Presenters;

namespace CourseManagement.Web
{
    public partial class ManageStudent : System.Web.UI.Page, IViewStudent, IViewCourse
    {
        StudentPresenter studentPresenter;
        CoursePresenter coursePresenter;
        public int AutoOpenDialog { get; set; }
        public int AutoOpenModifyCoursesDialog { get; set; }
        protected override void OnInit(EventArgs e)
        {
            studentPresenter = new StudentPresenter(this);
            coursePresenter = new CoursePresenter(this);
        }
        #region Page events
        protected void Page_Load(object sender, EventArgs e)
        {
            AutoOpenDialog = 0;
            AutoOpenModifyCoursesDialog = 0;
            HideMessages();
            if (!IsPostBack)
            {
                BindStudentList();
            }
        }
        #endregion

        #region Control Events
        protected void btnCourseSave_Click(object sender, EventArgs e)
        {
            this.Student = new Entity.Student();
            this.Student.StudentId = Convert.ToInt32(hdnCourseStudentId.Value);
            this.Student.CourseList = new List<Entity.Course>();
            foreach (ListItem item in chkCourses.Items)
            {
                if (item.Selected)
                    this.Student.CourseList.Add(new Entity.Course()
                    {
                        CourseId = Convert.ToInt32(item.Value),
                        CourseName = item.Text
                    });
            }
            studentPresenter.UpdateStudentCourseRef();
            //Refresh grid
            BindStudentList();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            this.Student = new Entity.Student();
            this.Student.StudentId = Convert.ToInt32(hdnDialogStudentId.Value);
            this.Student.StudentName = txtStudentName.Text.Trim();
            this.Student.Address = txtAddress.Text.Trim();
            this.Student.Phone = txtPhone.Text.Trim() ?? null;
            this.Student.Mobile = txtMobile.Text.Trim() ?? null;
            if (this.Student.StudentId > 0)
            {
                //Edit student mode
                studentPresenter.EditStudent();
                lblStudentUpdateSuccess.Visible = true;
            }
            else
            {
                //Add Student mode
                studentPresenter.AddStudent();
                lblStudentAddSuccess.Visible = true;
            }
            BindStudentList();
            ClearControls();
        }

        protected void lvStudent_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Entity.Student student = e.Item.DataItem as Entity.Student;
                if (student != null)
                {
                    LinkButton lbtnDelete = e.Item.FindControl("lbtnDelete") as LinkButton;
                    if (lbtnDelete != null)
                    {
                        lbtnDelete.Attributes.Add("onclick", "javascript: return DeleteStudent();");
                    }

                    Literal lblCoursesOpted = e.Item.FindControl("lblCoursesOpted") as Literal;
                    if (lblCoursesOpted != null)
                    {                       
                        foreach (var item in student.CourseList)
                        {
                            lblCoursesOpted.Text += item.CourseName + "<br />";
                        }                    
                    }

                    LinkButton lbtnModifyCourseOpted = e.Item.FindControl("lbtnModifyCourseOpted") as LinkButton;
                    if (lbtnModifyCourseOpted != null)
                    {
                        if (student.CourseList != null && student.CourseList.Count > 0)
                        {
                            lbtnModifyCourseOpted.Text = "Modify Courses";
                        }
                        else
                        {
                            lbtnModifyCourseOpted.Text = "Add Courses";
                        }
                    }
                }
            }
        }

        protected void lvStudent_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            HiddenField hdnStudentId = e.Item.FindControl("hdnStudentId") as HiddenField;
            if (e.CommandName == "EditCommand")
            {
                AutoOpenDialog = 1;
                this.Student = new Entity.Student();
                if (hdnStudentId != null && !string.IsNullOrEmpty(hdnStudentId.Value.Trim()))
                {
                    this.Student.StudentId = Convert.ToInt32(hdnStudentId.Value);
                    studentPresenter.GetStudentDetails();

                    hdnDialogStudentId.Value = this.Student.StudentId.ToString();
                    txtStudentName.Text = this.Student.StudentName.ToString();
                    txtAddress.Text = this.Student.Address;
                    txtMobile.Text = this.Student.Mobile ?? string.Empty;
                    txtPhone.Text = this.Student.Phone ?? string.Empty;
                }
            }

            if (e.CommandName == "DeleteCommand")
            {
                this.Student = new Entity.Student();
                if (hdnStudentId != null && !string.IsNullOrEmpty(hdnStudentId.Value.Trim()))
                {
                    this.Student.StudentId = Convert.ToInt32(hdnStudentId.Value);
                    studentPresenter.DeleteStudent();

                    //Refresh grid
                    BindStudentList();
                    lblStudentDeleteSuccess.Visible = true;
                }

            }

            if (e.CommandName == "ModifyCourses")
            {
                AutoOpenModifyCoursesDialog = 1;
                BindCourses();
                this.Student = new Entity.Student();
                if (hdnStudentId != null && !string.IsNullOrEmpty(hdnStudentId.Value.Trim()))
                {
                    hdnCourseStudentId.Value = hdnStudentId.Value;
                    this.Student.StudentId = Convert.ToInt32(hdnStudentId.Value);
                    //Get selected courses if any
                    studentPresenter.GetStudentCourseRef();

                    //Set Pre-selected courses if any
                    foreach (var item in this.Student.CourseList)
                    {
                        foreach (ListItem chk in chkCourses.Items)
                        {
                            if (item.CourseId == Convert.ToInt32(chk.Value))
                            {
                                chk.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }
        }
        #endregion

        #region Methods
        private void ClearControls()
        {
            hdnDialogStudentId.Value = "0";
            txtStudentName.Text = string.Empty;
            txtAddress.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtPhone.Text = string.Empty;
        }

        private void BindStudentList()
        {
            studentPresenter.GetStudents();
            lvStudents.DataSource = StudentList;
            lvStudents.DataBind();
        }

        private void BindCourses()
        {
            coursePresenter.GetCourses();
            chkCourses.DataSource = CourseList;
            chkCourses.DataTextField = "CourseName";
            chkCourses.DataValueField = "CourseId";
            chkCourses.DataBind();
        }
        private void HideMessages()
        {
            lblStudentDeleteSuccess.Visible = false;
            lblStudentDeleteError.Visible = false;
            lblStudentAddSuccess.Visible = false;
            lblStudentAddError.Visible = false;
            lblStudentUpdateSuccess.Visible = false;
            lblStudentUpdateError.Visible = false;
        }
        #endregion

        #region IViewStudent Implementation
        public List<Entity.Student> StudentList
        {
            get;
            set;
        }

        public Entity.Student Student
        {
            get;
            set;
        }
        #endregion

        #region IViewCourse Implementation
        public List<Entity.Course> CourseList
        {
            get;
            set;
        }

        public Entity.Course Course
        {
            get;
            set;
        }
        #endregion

       
        }
    }
