# start get-all-courses

resource "aws_iam_role" "get_all_courses_role" {
 name = "get-all-courses-role"

assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_policy" "get_all_courses_police" {

  policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:Scan",
            ],
            Effect   = "Allow",
            Resource = var.dynamodb_courses_arn
        },
        {
            Effect = "Allow",
            Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            Resource = "*"
        }
        ]
    }) 
}

resource "aws_iam_role_policy_attachment" "get_all_courses_policy_attachment" {
  role        = aws_iam_role.get_all_courses_role.name
  policy_arn  = aws_iam_policy.get_all_courses_police.arn
}

# end get-all-courses

# start get-course

resource "aws_iam_role" "get_course_role" {
 name = "get-course-role"

assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_policy" "get_course_police" {

  policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:GetItem",
            ],
            Effect   = "Allow",
            Resource = var.dynamodb_courses_arn
        },
        {
            Effect = "Allow",
            Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            Resource = "*"
        }
        ]
    }) 
}

resource "aws_iam_role_policy_attachment" "get_course_policy_attachment" {
  role        = aws_iam_role.get_course_role.name
  policy_arn  = aws_iam_policy.get_course_police.arn
}

# end get-course

# start save-course

resource "aws_iam_role" "save_course_role" {
 name = "save-course-role"

assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_policy" "save_course_police" {

  policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:PutItem",
            ],
            Effect   = "Allow",
            Resource = var.dynamodb_courses_arn
        },
        {
            Effect = "Allow",
            Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            Resource = "*"
        }
        ]
    }) 
}

resource "aws_iam_role_policy_attachment" "save_course_policy_attachment" {
  role        = aws_iam_role.save_course_role.name
  policy_arn  = aws_iam_policy.save_course_police.arn
}

# end save-course

# start update-course

resource "aws_iam_role" "update_course_role" {
 name = "update-course-role"

assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_policy" "update_course_police" {

  policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:PutItem",
            ],
            Effect   = "Allow",
            Resource = var.dynamodb_courses_arn
        },
        {
            Effect = "Allow",
            Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            Resource = "*"
        }
        ]
    }) 
}

resource "aws_iam_role_policy_attachment" "update_course_policy_attachment" {
  role        = aws_iam_role.update_course_role.name
  policy_arn  = aws_iam_policy.update_course_police.arn
}

# end update-course

# start delete-course

resource "aws_iam_role" "delete_course_role" {
 name = "delete-course-role"

assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_policy" "delete_course_police" {

  policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:DeleteItem",
            ],
            Effect   = "Allow",
            Resource = var.dynamodb_courses_arn
        },
        {
            Effect = "Allow",
            Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            Resource = "*"
        }
        ]
    }) 
}

resource "aws_iam_role_policy_attachment" "delete_course_policy_attachment" {
  role        = aws_iam_role.delete_course_role.name
  policy_arn  = aws_iam_policy.delete_course_police.arn
}

# end delete-course

# start get-all-authors

resource "aws_iam_role" "get_all_authors_role" {
 name = "get-all-authors-role"

assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow"
    }]
  })
}

resource "aws_iam_policy" "get_all_authors_police" {

  policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:Scan",
            ],
            Effect   = "Allow",
            //Resource = var.dynamodb_authors_arn
            Resource = var.dynamodb_authors_arn
        },
        {
            Effect = "Allow",
            Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            Resource = "*"
        }
        ]
    }) 
}

resource "aws_iam_role_policy_attachment" "get_all_authors_policy_attachment" {
  role        = aws_iam_role.get_all_authors_role.name
  policy_arn  = aws_iam_policy.get_all_authors_police.arn
}

# end get-all-courseauthorss