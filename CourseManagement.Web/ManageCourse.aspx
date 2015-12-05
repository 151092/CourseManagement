<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCourse.aspx.cs" MasterPageFile="~/Site.master"
    Inherits="CourseManagement.Web.ManageCourse" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">    
    <div>
        <table width="100%" border="0">
            <tr>
                <td>
                    <h2>Courses</h2>
                </td>
                <td align="right" valign="bottom">
                    <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" />                    
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblCourseDeleteSuccess" runat="server" Text="Course deleted successfully." ForeColor="Green"></asp:Label>
                    <asp:Label ID="lblCourseDeleteError" runat="server" Text="Error occurred on deleting course." ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblCourseAddSuccess" runat="server" Text="Course added successfully." ForeColor="Green"></asp:Label>
                    <asp:Label ID="lblCourseAddError" runat="server" Text="Error occurred on adding course." ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblCourseUpdateSuccess" runat="server" Text="Course updated successfully." ForeColor="Green"></asp:Label>
                    <asp:Label ID="lblCourseUpdateError" runat="server" Text="Error occurred on updating course." ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <p>
            <asp:ListView ID="lvCourses" runat="server" ItemPlaceholderID="phCourses" OnItemCommand="lvCourses_ItemCommand" OnItemDataBound="lvCourses_ItemDataBound">
                <LayoutTemplate>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr style="">
                            <td style="border-bottom: 1px solid #465c71; width: 50%;" align="left">
                                <b>Name</b>
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 20%;" align="right">
                                <b>Duration</b>
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 20%;" align="right">
                                <b>Fees</b>
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 5%;" align="center">
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 5%;" align="center">
                            </td>
                        </tr>
                        <asp:PlaceHolder ID="phCourses" runat="server"></asp:PlaceHolder>                        
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                <tr>
                    <td style="width: 50%;" align="left">
                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("CourseName") %>'></asp:Label>
                        <asp:HiddenField ID="hdnCourseId" runat="server" Value='<%# Eval("CourseId") %>' />
                    </td>
                    <td style="width: 20%;" align="right">
                        <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("CourseDuration") %>'></asp:Label>
                    </td>
                    <td style="width: 20%;" align="right">
                        <asp:Label ID="lblFees" runat="server" Text='<%# Eval("CourseFees") %>'></asp:Label>
                    </td>
                    <td style="width: 5%;" align="center">
                        <asp:LinkButton ID="lbtnEdit" runat="server" Text="Edit" CommandName="EditCommand"></asp:LinkButton>
                    </td>
                    <td style="width: 5%;" align="center">
                        <asp:LinkButton ID="lbtnDelete" runat="server" Text="Delete" CommandName="DeleteCommand"></asp:LinkButton>
                    </td>
                </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    No courses available!
                </EmptyDataTemplate>
            </asp:ListView>
        </p>
    </div>    
<div id="dvEditCourse">
    <asp:HiddenField ID="hdnDialogCourseId" runat="server" Value="0" />
    <table>
        <tr>
            <td colspan="2">
                <asp:ValidationSummary ID="vsummaryCourse" runat="server" ValidationGroup="SaveCourse" DisplayMode="List" style="color: Red;" />
            </td>
        </tr>
        <tr>
            <td>Name: </td>
            <td><asp:TextBox ID="txtCourseName" runat="server" MaxLength="99" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" ValidationGroup="SaveCourse" runat="server" ControlToValidate="txtCourseName" Display="None" ErrorMessage="Course name is empty"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Duration: </td>
            <td><asp:TextBox ID="txtCourseDuration" runat="server" MaxLength="3"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvDuration" ValidationGroup="SaveCourse" runat="server" ControlToValidate="txtCourseDuration" Display="None" ErrorMessage="Course duration is empty"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Fees: </td>
            <td><asp:TextBox ID="txtFees" runat="server" MaxLength="6"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFees" ValidationGroup="SaveCourse" runat="server" ControlToValidate="txtFees" Display="None" ErrorMessage="Course fees is empty"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnSave" ValidationGroup="SaveCourse" runat="server" Text="Save" OnClick="btnSave_Click" />
                &nbsp;
                <input type="button" id="btnCancel" value="Cancel" />
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('#dvEditCourse').dialog({
            title: 'Course Details',
            modal: true,
            resizable: false,
            autoOpen: <%= AutoOpenDialog %>,
            open: function(event, ui){
                $('#dvEditCourse').parent().appendTo('#dialogTarget');
                $('#<%= txtCourseDuration.ClientID %>').numeric({allow: '.' });
                $('#<%= txtFees.ClientID %>').numeric();
            },
            close: function(event, ui){
                $('#<%= txtCourseDuration.ClientID %>').val('');
                $('#<%= txtFees.ClientID %>').val('');
                $('#<%= txtCourseName.ClientID %>').val('');
                $('#<%= hdnDialogCourseId.ClientID %>').val('0');
            }
        });
        
        $('#<%= btnAddCourse.ClientID %>').click(function () {
            OpenCourseDialog();
            return false;
        });

        $('#btnCancel').click(function(){
            $('#dvEditCourse').dialog('close');
        });
    });

    function OpenCourseDialog() {
        $('#dvEditCourse').parent().appendTo('#dialogTarget');
        $('#dvEditCourse').dialog('open');
    
    };

    function DeleteCourse() {
        if (confirm('Are you sure you want to delete the selected course?'))
            return true;
        else
            return false;            
    };
</script>
</asp:Content>
