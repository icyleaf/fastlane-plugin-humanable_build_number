describe Fastlane::Actions::HumanableBuildNumberAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The humanable_build_number plugin is working!")

      Fastlane::Actions::HumanableBuildNumberAction.run(nil)
    end
  end
end
