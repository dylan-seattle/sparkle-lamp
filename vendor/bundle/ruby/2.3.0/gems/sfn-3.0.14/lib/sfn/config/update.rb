require 'sfn'

module Sfn
  class Config
    # Update command configuration
    class Update < Validate

      attribute(
        :apply_stack, String,
        :multiple => true,
        :description => 'Apply outputs from stack to input parameters',
        :short_flag => 'A'
      )
      attribute(
        :apply_mapping, Smash,
        :description => 'Customize apply stack mapping as [StackName__]OutputName:ParameterName'
      )
      attribute(
        :parameter, Smash,
        :multiple => true,
        :description => '[DEPRECATED - use `parameters`] Pass template parameters directly (ParamName:ParamValue)',
        :coerce => lambda{|v, inst|
          result = inst.data[:parameter] || Array.new
          case v
          when String
            v.split(',').each do |item|
              result.push(Smash[*item.split(/[=:]/, 2)])
            end
          else
            result.push(v.to_smash)
          end
          {:bogo_multiple => result}
        },
        :short_flag => 'R'
      )
      attribute(
        :parameters, Smash,
        :description => 'Pass template parameters directly',
        :short_flag => 'm'
      )
      attribute(
        :plan, [TrueClass, FalseClass],
        :default => true,
        :description => 'Provide planning information prior to update',
        :short_flag => 'l'
      )
      attribute(
        :plan_only, [TrueClass, FalseClass],
        :default => false,
        :description => 'Exit after plan display'
      )
      attribute(
        :diffs, [TrueClass, FalseClass],
        :description => 'Show planner content diff',
        :short_flag => 'D'
      )
      attribute(
        :merge_api_options, [TrueClass, FalseClass],
        :description => 'Merge API options defined within configuration on update',
        :default => false
      )
      attribute(
        :parameter_validation, String,
        :allowed => ['default', 'none', 'current', 'expected'],
        :description => 'Stack parameter validation behavior',
        :default => 'default'
      )

    end
  end
end
