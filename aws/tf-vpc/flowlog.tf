resource "aws_flow_log" "ba_vpc_flow_log" {
    iam_role_arn = aws_iam_role.flow_log.arn
    log_destination = aws_cloudwatch_log_group.flow_log.arn
    traffic_type = "ALL"
    vpc_id = aws_vpc.vpc.id
}

resource "aws_cloudwatch_log_group" "flow_log" {
    name = "/aws/vpc/flowlog"
}

resource "aws_iam_role" "flow_log" {
    name = "vpc_flowlog_role"
    assume_role_policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "",
                "Effect": "Allow",
                "Principal": {
                    "Service": "vpc-flow-logs.amazonaws.com"
                },
                "Action": "sts:AssumeRole"
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy" "flow_log" {
    name = "vpc_flowlog_policy"
    role = aws_iam_role.flow_log.id

    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
    EOF
}