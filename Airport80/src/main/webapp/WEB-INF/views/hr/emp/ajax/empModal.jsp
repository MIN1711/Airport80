<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<table class="table table-bordered">
	<tr>
		<th><spring:message code="emp.empNo" /></th>
		<td>${emp.empNo }</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empNm" /></th>
		<td>${emp.empNm }</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empStatus" /></th>
		<td>
			<c:choose>
	            <c:when test="${emp.empStatus == 0}">신규</c:when>
	            <c:when test="${emp.empStatus == 1}">출근</c:when>
	            <c:when test="${emp.empStatus == 2}">퇴근</c:when>
	            <c:when test="${emp.empStatus == 3}">휴가</c:when>
	            <c:when test="${emp.empStatus == 4}">퇴사</c:when>
	        </c:choose>		
		</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empBir" /></th>
		<td>${emp.empBir }</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empGender" /></th>
		<td>
			<c:choose>
				<c:when test="${emp.empGender == 'F'}">여성</c:when>
				<c:when test="${emp.empGender == 'M'}">남성</c:when>
			</c:choose>
		</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empEmail" /></th>
		<td>${emp.empEmail }@${emp.empEmailDo }</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empAddr" /></th>
		<td>${emp.empAddr }</td>
	</tr>
	<tr>
		<th>상세주소</th>
		<td>${emp.empDetailAddr }</td>
	</tr>
	<tr>
		<th>우편번호</th>
		<td>${emp.empPost }</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empContact" /></th>
		<td>
			<c:set var="contact" value="${emp.empContact}" />
	        <c:set var="formattedContact" value="${fn:substring(contact, 0, 3)}-${fn:substring(contact, 3, 7)}-${fn:substring(contact, 7, fn:length(contact))}" />
	        ${formattedContact}
		</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empJoinDt" /></th>
		<td>${emp.empJoinDt }</td>
	</tr>
	<tr>
		<th><spring:message code="emp.empDeptNo" /></th>
		<td>
		    <c:choose>
		        <c:when test="${emp.empDeptNo == 1201}">
		            <c:choose>
		                <c:when test="${emp.empTeam == 31}">인사</c:when>
		                <c:when test="${emp.empTeam == 32}">회계</c:when>
		            </c:choose>
		        </c:when>
		        <c:when test="${emp.empDeptNo == 1202}">운영</c:when>
		        <c:when test="${emp.empDeptNo == 1203}">보안</c:when>
		        <c:when test="${emp.empDeptNo == 1204}">인프라</c:when>
		    </c:choose>	
		</td>
	</tr>
	<tr>
		<th>거래은행</th>
		<td>${emp.empAccnum }</td>
	</tr>
	<tr>
		<th>계좌번호</th>
		<td>${emp.empAccbank }</td>
	</tr>
	<tr>
	<th>첨부파일</th>
	<td colspan="3"><c:if
			test="${not empty emp.fileGroup and not empty emp.fileGroup.detailList }">
			<c:forEach items="${emp.fileGroup.detailList }"
				var="fileDetail">
				<c:url value="/download.do" var="downloadURL">
					<c:param name="atchFileId" value="${fileDetail.atchFileId }" />
					<c:param name="fiSn" value="${fileDetail.fiSn }" />
				</c:url>
				<i class="bi bi-paperclip">
				<a href="${downloadURL }">${fileDetail.fiOriginNm }</a>
				</i>
			</c:forEach>
		</c:if>
	</td>
</tr>
	<tr>
		<td colspan="2">
			<c:url value='/hr/emp/empUpdate.do' var="updateURL">
				<c:param name="what" value="${emp.empNo }" />
			</c:url>
			<a href="${updateURL }" class="btn btn-primary">수정</a>
			<a class="btn btn-secondary" href="<c:url value='/hr/emp/empList.do'/>">목록</a>
		</td>
	</tr>
	
</table>

