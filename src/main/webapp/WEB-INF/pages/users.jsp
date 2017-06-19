<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<html>
<head>
  <title>user Page</title>

  <style type="text/css">
    .tg {
      border-collapse: collapse;
      border-spacing: 0;
      border-color: #ccc;
    }

    .tg td {
      font-family: Arial, sans-serif;
      font-size: 14px;
      padding: 10px 5px;
      border-style: solid;
      border-width: 1px;
      overflow: hidden;
      word-break: normal;
      border-color: #ccc;
      color: #333;
      background-color: #fff;
    }

    .tg th {
      font-family: Arial, sans-serif;
      font-size: 14px;
      font-weight: normal;
      padding: 10px 5px;
      border-style: solid;
      border-width: 1px;
      overflow: hidden;
      word-break: normal;
      border-color: #ccc;
      color: #333;
      background-color: #f0f0f0;
    }

    .tg .tg-4eph {
      background-color: #f9f9f9
    }
  </style>
</head>
<body>
<a href="../../index.jsp">Back to main menu</a>

<br/>
<br/>

<div class="row">
    <form method="get" action="/users/search">
        <div class="small-3 columns">
            <input type="text" id ="txt" name="searchString" value="${searchString}" >
        </div>

        <div class="small-5 columns end">
            <button id="button-id" type="submit">Search</button>
        </div>
    </form>
</div>


<h1>User list</h1>

<c:if test="${!empty listUsers}">
    <table class="tg">
        <tr>
            <th width="80">id</th>
            <th width="120">name</th>
            <th width="120">age</th>
            <th width="60">isAdmin</th>
            <th width="120">createdDate</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
        </tr>
        <c:forEach items="${listUsers}" var="user">
        <tr>
            <td>${user.id}</td>
            <td><a href="/userdata/${user.id}" target="_blank">${user.name}</a></td>
            <td>${user.age}</td>
            <td>${user.admin}</td>
            <td>${user.createdDate}</td>
            <td><a href="<c:url value='/edit/${user.id}'/>">Edit</a></td>
            <td><a href="<c:url value='/remove/${user.id}'/>">Delete</a></td>
        </tr>
        </c:forEach>
    </table>
</c:if>

<div id="pagination">

    <c:url value="/users" var="prev">
        <c:param name="page" value="${page-1}"/>
    </c:url>
    <c:if test="${page > 1}">
        <a href="<c:out value="${prev}" />" class="pn prev">Prev</a>
    </c:if>

    <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
        <c:choose>
            <c:when test="${page == i.index}">
                <span>${i.index}</span>
            </c:when>
            <c:otherwise>
                <c:url value="/users" var="url">
                    <c:param name="page" value="${i.index}"/>
                </c:url>
                <a href='<c:out value="${url}" />'>${i.index}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <c:url value="/users" var="next">
        <c:param name="page" value="${page + 1}"/>
    </c:url>
    <c:if test="${page + 1 <= maxPages}">
        <a href='<c:out value="${next}" />' class="pn next">Next</a>
    </c:if>
</div>


<h1>Add a User</h1>

<c:url var="addAction" value="/users/add"> </c:url>

    <form:form action="${addAction}" commandName="user">
        <table>
            <c:if test="${!empty user.name}">
                <tr>
                    <td>
                        <form:label path="id">
                            <spring:message text="id"/>
                        </form:label>
                    </td>
                    <td>
                        <form:input path="id" readonly="true" size="8" disabled="true"/>
                        <form:hidden path="id"/>
                    </td>
                </tr>
            </c:if>
            <tr>
                <td>
                    <form:label path="name">
                        <spring:message text="Name"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="name"/>
                </td>
            </tr>
            <tr>
                <td>
                    <form:label path="age">
                        <spring:message text="age"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="age"/>
                </td>
            </tr>
            <tr>
                <td>
                    <form:label path="admin">
                        <spring:message text="admin"/>
                    </form:label>
                </td>
                <td>
                    <form:checkbox path="admin"/>
                </td>
            </tr>
            <tr>
                <td colspan="2" bgcolor="#FBF0DB">
                    <c:if test="${!empty user.name}">
                        <input type="submit"
                               value="<spring:message text="Edit User"/>"/>
                    </c:if>
                    <c:if test="${empty user.name}">
                        <input type="submit"
                               value="<spring:message text="Add User"/>"/>
                    </c:if>
                </td>
            </tr>
        </table>
    </form:form>

</body>
</html>
