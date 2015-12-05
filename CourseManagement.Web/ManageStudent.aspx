<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageStudent.aspx.cs" Inherits="CourseManagement.Web.ManageStudent" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
    <table width="100%" border="0">
            <tr>
                <td>
                    <h2>Students</h2>
                </td>
                <td align="right" valign="bottom">
                    <asp:Button ID="btnAddStudent" runat="server" Text="Add Student" />                    
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblStudentDeleteSuccess" runat="server" Text="Student deleted successfully." ForeColor="Green"></asp:Label>
                    <asp:Label ID="lblStudentDeleteError" runat="server" Text="Error occurred on deleting student." ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblStudentAddSuccess" runat="server" Text="Student added successfully." ForeColor="Green"></asp:Label>
                    <asp:Label ID="lblStudentAddError" runat="server" Text="Error occurred on adding student." ForeColor="Red"></asp:Label>
                    <asp:Label ID="lblStudentUpdateSuccess" runat="server" Text="Student updated successfully." ForeColor="Green"></asp:Label>
                    <asp:Label ID="lblStudentUpdateError" runat="server" Text="Error occurred on updating student." ForeColor="Red"></asp:Label>
                </td>
            </tr>
        </table>
        </div>
        <div>
            <p>
                <asp:ListView ID="lvStudents" runat="server" ItemPlaceholderID="phStudents" 
                    OnItemCommand="lvStudent_ItemCommand" OnItemDataBound="lvStudent_ItemDataBound" 
                    >
                <LayoutTemplate>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr style="">
                            <td style="border-bottom: 1px solid #465c71; width: 15%;" align="left">
                                <b>Name</b>
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 25%;" align="left">
                                <b>Course Opted</b>
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 15%;" align="left">
                                <b>Address</b>
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 10%;" align="left">
                                <b>Phone</b>
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 10%;" align="left">
                                <b>Mobile</b>
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 10%;" align="left">                            
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 5%;" align="center">
                            </td>
                            <td style="border-bottom: 1px solid #465c71; width: 5%;" align="center">
                            </td>
                        </tr>
                        <asp:PlaceHolder ID="phStudents" runat="server"></asp:PlaceHolder>                        
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                <tr>
                    <td style="width: 20%;" align="left" valign="top">
                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("StudentName") %>'></asp:Label>
                        <asp:HiddenField ID="hdnStudentId" runat="server" Value='<%# Eval("StudentId") %>' />
                    </td>
                    <td style="width: 25%;" align="left" valign="top">
                        <asp:Literal ID="lblCoursesOpted" runat="server"></asp:Literal>                      
                    </td>
                    <td style="width: 15%;" align="left" valign="top">
                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                    </td>
                    <td style="width: 10%;" align="left" valign="top">
                        <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                    </td>
                    <td style="width: 10%;" align="left" valign="top">
                        <asp:Label ID="lblMobile" runat="server" Text='<%# Eval("Mobile") %>'></asp:Label>
                    </td>
                    <td style="width: 5%;" align="center" valign="top">
                        <asp:LinkButton ID="lbtnModifyCourseOpted" runat="server" Text="Modify Courses" CommandName="ModifyCourses"></asp:LinkButton> 
                    </td>
                    <td style="width: 5%;" align="center" valign="top">
                        <asp:LinkButton ID="lbtnEdit" runat="server" Text="Edit" CommandName="EditCommand"></asp:LinkButton>
                    </td>
                    <td style="width: 5%;" align="center" valign="top">
                        <asp:LinkButton ID="lbtnDelete" runat="server" Text="Delete" CommandName="DeleteCommand"></asp:LinkButton>
                    </td>
                </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    No students available!
                </EmptyDataTemplate>
            </asp:ListView>
            </p>
    </div>
<div id="dvEditStudent">
    <asp:HiddenField ID="hdnDialogStudentId" runat="server" Value="0" />
    <table>
        <tr>
            <td colspan="2">
                <asp:ValidationSummary ID="vsummaryStudent" runat="server" ValidationGroup="SaveStudent" DisplayMode="List" style="color: Red;" />
            </td>
        </tr>
        <tr>
            <td>Name: </td>
            <td><asp:TextBox ID="txtStudentName" runat="server" MaxLength="99" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" ValidationGroup="SaveStudent" runat="server" ControlToValidate="txtStudentName" Display="None" ErrorMessage="Student name is empty"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Address: </td>
            <td><asp:TextBox ID="txtAddress" runat="server" MaxLength="199" TextMode="MultiLine" Width="165px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvAddress" ValidationGroup="SaveStudent" runat="server" ControlToValidate="txtAddress" Display="None" ErrorMessage="Student address is empty"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Phone: </td>
            <td><asp:TextBox ID="txtPhone" runat="server" MaxLength="10"></asp:TextBox>            
            </td>
        </tr>
        <tr>
            <td>Mobile: </td>
            <td><asp:TextBox ID="txtMobile" runat="server" MaxLength="10"></asp:TextBox>            
            </td>
        </tr>      
        <tr>
            <td colspan="2">
                <asp:Button ID="btnSave" ValidationGroup="SaveStudent" runat="server" Text="Save" OnClick="btnSave_Click" />
                &nbsp;
                <input type="button" id="btnCancel" value="Cancel" />
            </td>
        </tr>
    </table>
</div>
<div id="dvEditCourse">
    <asp:HiddenField ID="hdnCourseStudentId" runat="server" Value="0" />
    <asp:CheckBoxList ID="chkCourses" runat="server"></asp:CheckBoxList>
    <br />
    <asp:Button ID="btnCourseSave" runat="server" Text="Save" OnClick="btnCourseSave_Click" />
    &nbsp;
    <input type="button" id="btnCourseCancel" value="Cancel" />
</div>
<script type="text/javascript" >
    $(document).ready(function () {
        $('#dvEditStudent').dialog({
            title: 'Student Details',
            modal: true,
            resizable: false,
            autoOpen: <%= AutoOpenDialog %>,            
            open: function(event, ui){
                $('#dvEditStudent').parent().appendTo('#dialogTarget');
                $('#<%= txtPhone.ClientID %>').numeric();
                $('#<%= txtMobile.ClientID %>').numeric();
            },
            close: function(event, ui){
                $('#<%= txtPhone.ClientID %>').val('');
                $('#<%= txtMobile.ClientID %>').val('');
                $('#<%= txtStudentName.ClientID %>').val('');
                $('#<%= txtAddress.ClientID %>').val('');
                $('#<%= hdnDialogStudentId.ClientID %>').val('0');
            }
        });
        
        $('#<%= btnAddStudent.ClientID %>').click(function () {
            OpenCourseDialog();
            return false;
        });

        $('#btnCancel').click(function(){
            $('#dvEditStudent').dialog('close');
        });
      
        $('#dvEditCourse').dialog({
            title: 'Course List',
            modal: true,
            resizable: false,
            autoOpen: <%= AutoOpenModifyCoursesDialog %>,
            open: function(event, ui){
                $('#dvEditCourse').parent().appendTo('#dialogTarget');               
            },
            close: function(event, ui){
                           
            }
        });         

        $('#btnCourseCancel').click(function(){
            $('#dvEditCourse').dialog('close');
        });

    });

    function OpenCourseDialog() {
        $('#dvEditStudent').parent().appendTo('#dialogTarget');
        $('#dvEditStudent').dialog('open');
    
    };

    function DeleteStudent() {
        if (confirm('Are you sure you want to delete the selected student?'))
            return true;
        else
            return false;            
    };
</script>

</asp:Content>
