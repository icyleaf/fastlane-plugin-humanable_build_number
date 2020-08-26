module Fastlane
  module Actions
    module SharedValues
      HUMANABLE_BUILD_NUMBER = :HUMANABLE_BUILD_NUMBER
    end

    class HumanableBuildNumberAction < Action
      def self.run(params)
        if GetBuildNumberRepositoryAction.is_git?
          generate_git_commit_number!(params[:date_format])
          UI.message 'humanable detect: git'
        else
          UI.message 'humanable detect: current datetime'
          generate_build_number!(params[:date_format])
        end

        UI.message "humanable build number: #{@build_number.green}"

        set_humanable_build_number! if params[:update]
        @build_number
      end

      def self.set_humanable_build_number!
        unless Helper::HumanableBuildNumberHelper.ios_project?
          UI.important "Can not set build number for android project"
          UI.important Helper::HumanableBuildNumberHelper.set_build_number_for_android_tips
          return
        end

        UI.message 'set build number to xcode project'
        require 'fastlane/actions/increment_build_number'
        require 'fastlane/helper/sh_helper'
        Fastlane::Actions::IncrementBuildNumberAction.run(build_number: @build_number)
      end

      def self.generate_git_commit_number!(format)
        git_last_commit_datetime = Actions.last_git_commit_formatted_with('%ci')
        @build_number = Helper::HumanableBuildNumberHelper.cook_humanable(git_last_commit_datetime, format: format)
      end

      def self.generate_build_number!(format)
        @build_number = Helper::HumanableBuildNumberHelper.cook_humanable(format: format)
      end

      def self.description
        "Automatic generate app build number unque and human readable friendly, like yymmHHMM. both support iOS and Android."
      end

      def self.authors
        ["icyleaf <icyleaf.cn@gmail.com>"]
      end

      def self.output
        [
          [SharedValues::HUMANABLE_BUILD_NUMBER.to_s, 'The humanable build number, like `yymmddHHMM`']
        ]
      end

      def self.return_value
        'The humanable build number'
      end

      def self.details
        "The default will using the datetime of git last commit, but else the datetime of build and formatted to yymmHHMM. "
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :update,
                                       env_name: 'HUMANABLE_UPDATE',
                                       description: 'Set the build number to xcode configuration file',
                                       default_value: false,
                                       is_string: false),
          FastlaneCore::ConfigItem.new(key: :date_format,
                                       env_name: 'HUMANABLE_DATE_FORMAT',
                                       description: 'Set formatter of build_number',
                                       default_value: '%m%d%H%M',
                                       is_string: true)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
