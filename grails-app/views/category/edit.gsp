<!DOCTYPE html>
<html>

<head>
  <meta name="layout" content="main" />
  <g:set var="entityName" value="${message(code: 'category.label', default: 'Category')}" />
  <title>
    <g:message code="default.edit.label" args="[entityName]" />
  </title>
</head>

<body>
  <a href="#edit-category" class="ui hidden message" tabindex="-1">
    <g:message code="default.link.skip.label" default="Skip to content&hellip;" />
  </a>
  <!-- messages -->
  <g:if test="${flash.message}">
    <div class="ui positive message">
      <i class="close icon"></i> ${flash.message}
    </div>
  </g:if>
  <g:hasErrors bean="${this.category}">
    <div class="ui error message">
      <i class="close icon"></i>
      <g:eachError bean="${this.category}" var="error">
        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>>
          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
          <g:message error="${error}" />
        </li>
      </g:eachError>
    </div>
  </g:hasErrors>
  <!-- buttons -->
  <div class="ui two buttons">
    <g:link class="ui blue fluid button " action="create">
      <g:message code="default.new.label" args="[entityName]" /></g:link>
  </div>
  <h3><g:message code="default.edit.label" args="[entityName]"/></h3>
  <!-- form -->
  <div id="edit-category" class="content scaffold-edit" role="main">
    <g:form resource="${this.category}" method="PUT" class="ui form" role="form">
      <g:hiddenField name="version" value="${this.category?.version}" />
      <g:hiddenField name="categoryType" value="${flash.categoryType}" />
      <div class="field">
        <label>
        <g:message code="category.category.label"/>
      </label>
        <f:input bean="category" property="name" />
      </div>
      <div class="field">
        <label>
        <g:message code="category.type.label"/>
      </label>
        <g:select class="ui fluid dropdown" name="type" value="${category.type}" from='${categoryTypes}' optionKey="id" optionValue="name"></g:select>
      </div>
      <div class="field">
        <label>
        <g:message code="category.color.label"/>
      </label>
        <f:input bean="category" property="color" type="color" />
      </div>
      <div class="field">
        <label>
        <g:message code="category.order.label"/>
      </label>
        <f:input bean="category" property="order" />
      </div>
      <div class="inline field">
        <label>
        <g:message code="category.active.label"/>
      </label>
        <div class="ui checkbox">
          <f:input bean="category" property="active" />
        </div>
      </div>
      <div class="field">
        <label>
        <g:message code="category.description.label"/>
      </label>
        <f:input bean="category" property="description" />
      </div>
      <div class="field">
        <label>
        <g:message code="category.parent.label"/>
      </label>
        <g:select class="ui fluid dropdown" name="parent" value="${category.parent.id}" noSelection="${['null': '']}" from='${categories}' optionKey="id" optionValue="name"></g:select>
      </div>
      <input class="ui blue fluid button " type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
    </g:form>
  </div>
</body>

</html>
