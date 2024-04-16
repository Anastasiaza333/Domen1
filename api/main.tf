resource "aws_api_gateway_rest_api" "api" { 
  name = "api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_rest_api.api.root_resource_id
  path_part = "authors"
}
resource "aws_api_gateway_resource" "courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_rest_api.api.root_resource_id
  path_part = "course"
}

resource "aws_api_gateway_resource" "courses_get" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_resource.courses.id
  path_part = "get"
}
resource "aws_api_gateway_resource" "courses_get_id" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_resource.courses_get.id
  path_part = "{id}"
}

resource "aws_api_gateway_resource" "courses_delete" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_resource.courses.id
  path_part = "delete"
}
resource "aws_api_gateway_resource" "courses_delete_id" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_resource.courses_delete.id
  path_part = "{id}"
}

resource "aws_api_gateway_resource" "courses_save" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_resource.courses.id
  path_part = "save"
}

resource "aws_api_gateway_resource" "courses_update" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id = aws_api_gateway_resource.courses.id
  path_part = "update"
}



resource "aws_api_gateway_stage" "dev" {
    deployment_id = aws_api_gateway_deployment.this.id
    rest_api_id = aws_api_gateway_rest_api.api.id
    stage_name = "stage"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api.body))
  }

 depends_on = [
    aws_api_gateway_method.get_all_authors,
    aws_api_gateway_method.get_all_courses,
    aws_api_gateway_method.get_course,
    aws_api_gateway_method.delete_course,
    aws_api_gateway_method.save_course,
    aws_api_gateway_method.update_course
  ]

}

# start get-all-authors

resource "aws_api_gateway_method" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_all_authors.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.get_all_authors_invoke_arn
}


resource "aws_api_gateway_method_response" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_all_authors.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "get_all_authors" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.authors.id
  http_method = aws_api_gateway_method.get_all_authors.http_method
  status_code = aws_api_gateway_method_response.get_all_authors.status_code
}

resource "aws_lambda_permission" "get_all_authors" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.get_all_authors_arn
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# end get-all-authors

# start get-all-courses

resource "aws_api_gateway_method" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_all_courses.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.get_all_courses_invoke_arn
}

resource "aws_api_gateway_method_response" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_all_courses.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "get_all_courses" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses.id
  http_method = aws_api_gateway_method.get_all_courses.http_method
  status_code = aws_api_gateway_method_response.get_all_courses.status_code
}

resource "aws_lambda_permission" "get_all_courses" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.get_all_courses_arn
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# end get-all-courses

# start get-course

resource "aws_api_gateway_method" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_get_id.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_get_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.get_course_invoke_arn
   request_templates       = {
    "application/json" = "{\"id\": \"$input.params('id')\"}"
  }
}

resource "aws_api_gateway_method_response" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_get_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "get_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_get_id.id
  http_method = aws_api_gateway_method.get_course.http_method
  status_code = aws_api_gateway_method_response.get_course.status_code
}

resource "aws_lambda_permission" "get_course" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.get_course_arn
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# end get-course

# start delete-course

resource "aws_api_gateway_method" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_delete_id.id
  http_method = "DELETE"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_delete_id.id
  http_method = aws_api_gateway_method.delete_course.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.delete_course_invoke_arn
   request_templates       = {
    "application/json" = "{\"id\": \"$input.params('id')\"}"
  }
}

resource "aws_api_gateway_method_response" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_delete_id.id
  http_method = aws_api_gateway_method.delete_course.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "delete_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_delete_id.id
  http_method = aws_api_gateway_method.delete_course.http_method
  status_code = aws_api_gateway_method_response.delete_course.status_code
}

resource "aws_lambda_permission" "delete_course" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.delete_course_arn
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# end dalete-course

# start save-course

resource "aws_api_gateway_method" "update_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_update.id
  http_method = "PUT"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "update_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_update.id
  http_method = aws_api_gateway_method.update_course.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.update_course_invoke_arn
}

resource "aws_api_gateway_method_response" "update_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_update.id
  http_method = aws_api_gateway_method.update_course.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "update_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_update.id
  http_method = aws_api_gateway_method.update_course.http_method
  status_code = aws_api_gateway_method_response.update_course.status_code
}

resource "aws_lambda_permission" "update_course" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.update_course_arn
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# end update-course

# start update-course

resource "aws_api_gateway_method" "save_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_save.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "save_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_save.id
  http_method = aws_api_gateway_method.save_course.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.save_course_invoke_arn
}

resource "aws_api_gateway_method_response" "save_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_save.id
  http_method = aws_api_gateway_method.save_course.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "save_course" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.courses_save.id
  http_method = aws_api_gateway_method.save_course.http_method
  status_code = aws_api_gateway_method_response.save_course.status_code
}

resource "aws_lambda_permission" "save_course" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.save_course_arn
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# end save-course