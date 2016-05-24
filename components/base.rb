SparkleFormation.build do
  set!('AWSTemplateFormatVersion', '2010-09-09')

  parameters.key_name do
    type 'String'
    description 'KeyName to use with LaunchConfiguration resource'
    default 'SparkleKey'
  end

  resources.cfn_user do
    type 'AWS::IAM::User'
    properties.path '/'
    properties.policies _array(
      -> {
        policy_name 'cfn_access'
        policy_document.statement _array(
          -> {
            effect 'Allow'
            action 'cloudformation:DescribeStackResource'
            resource '*'
          }
        )
      }
    )
  end

  resources.cfn_keys do
    type 'AWS::IAM::AccessKey'
    properties.user_name ref!(:cfn_user)
  end

end