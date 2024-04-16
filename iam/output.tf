output "get_all_courses_role_arn" {
  value = aws_iam_role.get_all_courses_role.arn
}

output "get_course_role_arn" {
  value = aws_iam_role.get_course_role.arn
}

output "save_course_role_arn" {
  value = aws_iam_role.save_course_role.arn
}

output "update_course_role_arn" {
  value = aws_iam_role.update_course_role.arn
}

output "delete_course_role_arn" {
  value = aws_iam_role.delete_course_role.arn
}

output "get_all_authors_role_arn" {
  value = aws_iam_role.get_all_authors_role.arn
}