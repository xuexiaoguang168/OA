<% String rootpath = request.getContextPath(); %>
function openWinForFlowAccess(url,width,height)
{
	var newwin = window.open(url,"_blank","toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,top=250,left=350,width="+width+",height="+height);
}

var inputObj;
function setIntpuObjValue(v) {
	inputObj.value = v;
}

// function addInputObjValue(v) {
//	 inputObj.value += v;
// }

function openWinSign(obj) {
	inputObj = obj;
	openWinForFlowAccess("<%=rootpath%>/flow/macro_ctl_sign_win.jsp", 200, 10);
}

function openWinIdea(obj) {
	inputObj = obj;
	openWinForFlowAccess("<%=rootpath%>/flow/macro_ctl_idea_win.jsp", 400, 200);
}

function openWinCustomerList(obj) {
	inputObj = obj
	openWinForFlowAccess("<%=rootpath%>/sales/customer_list_sel.jsp", 520, 480);
}

function openWinLinkmanList(obj) {
	inputObj = obj
	openWinForFlowAccess("<%=rootpath%>/sales/linkman_list_sel.jsp", 520, 480);
}

function openWinProviderList(obj) {
	inputObj = obj
	openWinForFlowAccess("<%=rootpath%>/sales/provider_info_list_sel.jsp", 520, 480);
}

function openWinProductList(obj) {
	inputObj = obj
	openWinForFlowAccess("<%=rootpath%>/sales/product_list_sel.jsp", 520, 480);
}

function openWinProductServiceList(obj) {
	inputObj = obj
	openWinForFlowAccess("<%=rootpath%>/sales/product_service_list_sel.jsp", 520, 480);
}