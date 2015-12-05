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
    public partial class ManageCourse : System.Web.UI.Page, IViewCourse
    {
        CoursePresenter coursePresenter;
        public int AutoOpenDialog { get; set; }
        protected override void OnInit(EventArgs e)
        {
            coursePresenter = new CoursePresenter(this);
        }
        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            AutoOpenDialog = 0;
            HideMessages();
            if (!IsPostBack)
            {
                BindCourseList();
            }
        }
        #endregion

        #region Control Events
        protected void btnSave_Click(object sender, EventArgs e)
        {
            this.Course = new Entity.Course();
            this.Course.CourseId = Convert.ToInt32(hdnDialogCourseId.Value);
            this.Course.CourseName = txtCourseName.Text.Trim();
            this.Course.CourseFees = Convert.ToInt32(txtFees.Text.Trim());
            this.Course.CourseDuration = Convert.ToDecimal(txtCourseDuration.Text.Trim());
            if (this.Course.CourseId > 0)
            {
                //Edit course mode
                coursePresenter.EditCourse();
                lblCourseUpdateSuccess.Visible = true;
            }
            else
            {
                //Add Course mode
                coursePresenter.AddCourse();
                lblCourseAddSuccess.Visible = true;
            }
            BindCourseList();
            ClearControls();
        }

        protected void lvCourses_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Entity.Course course = e.Item.DataItem as Entity.Course;
                if (course != null)
                {
                    LinkButton lbtnDelete = e.Item.FindControl("lbtnDelete") as LinkButton;
                    if (lbtnDelete != null)
                    {
                        lbtnDelete.Attributes.Add("onclick", "javascript: return DeleteCourse();");
                    }
                }
            }
        }

        protected void lvCourses_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            HiddenField hdnCourseId = e.Item.FindControl("hdnCourseId") as HiddenField;
            if (e.CommandName == "EditCommand")
            {
                AutoOpenDialog = 1;
                this.Course = new Entity.Course();
                if (hdnCourseId != null && !string.IsNullOrEmpty(hdnCourseId.Value.Trim()))
                {
                    this.Course.CourseId = Convert.ToInt32(hdnCourseId.Value);
                    coursePresenter.GetCourseDetails();

                    hdnDialogCourseId.Value = this.Course.CourseId.ToString();
                    txtCourseDuration.Text = this.Course.CourseDuration.ToString();
                    txtCourseName.Text = this.Course.CourseName;
                    txtFees.Text = this.Course.CourseFees.ToString();
                }
            }

            if (e.CommandName == "DeleteCommand")
            {
                this.Course = new Entity.Course();
                if (hdnCourseId != null && !string.IsNullOrEmpty(hdnCourseId.Value.Trim()))
                {
                    this.Course.CourseId = Convert.ToInt32(hdnCourseId.Value);
                    coursePresenter.DeleteCourse();

                    //Refresh grid
                    BindCourseList();
                    lblCourseDeleteSuccess.Visible = true;
                }

            }
        }
        #endregion

        #region Methods
        private void ClearControls()
        {
            hdnDialogCourseId.Value = "0";
            txtCourseDuration.Text = string.Empty;
            txtCourseName.Text = string.Empty;
            txtFees.Text = string.Empty;
        }

        private void BindCourseList()
        {
            coursePresenter.GetCourses();
            lvCourses.DataSource = CourseList;
            lvCourses.DataBind();
        }

        private void HideMessages()
        {
            lblCourseDeleteSuccess.Visible = false;
            lblCourseDeleteError.Visible = false;
            lblCourseAddSuccess.Visible = false;
            lblCourseAddError.Visible = false;
            lblCourseUpdateSuccess.Visible = false;
            lblCourseUpdateError.Visible = false;
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