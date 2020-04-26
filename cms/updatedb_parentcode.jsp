<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="cn.js.fan.security.*"%>
<%@ page import="cn.js.fan.util.*"%>
<%@ page import="cn.js.fan.db.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="cn.js.fan.web.*"%>
<%@ page import="com.fan.redmoon.Privilege"%>
<%@ page import="cn.js.fan.module.cms.*"%>
<%@ page import="java.util.Calendar" %>
<%
        Conn conn = new Conn("redmoon");
		Conn conn1 = new Conn("redmoon");
		ResultSet rs = null;
        try {
			String sql = "select id,class1 from document";
			rs = conn.executeQuery(sql);
			while(rs.next()) {
				int id = rs.getInt(1);
				String dirCode = rs.getString(2);
				Leaf lf = new Leaf();
				lf = lf.getLeaf(dirCode);
				String parent_code = lf.getParentCode();
				String query = "update document set parent_code=" + StrUtil.sqlstr(parent_code)
								+ " where id=" + id;
				conn1.executeUpdate(query);
			}
        }
        catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        finally {
			if (rs!=null) {
				rs.close();
				rs = null;
			}
            if (conn!=null) {
                conn.close(); conn = null;
            }
			if (conn1!=null) {
				conn1.close(); conn1 = null;
			}
        }
		out.print("操作完成！");
%>