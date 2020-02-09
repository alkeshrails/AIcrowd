require 'rails_helper'

describe "download dataset links" do
  let!(:challenge) { create :challenge, :running }
  let!(:participation_terms) { create :participation_terms }
  let!(:participant) { create :participant }
  let!(:challenge_participant) { create :challenge_participant, challenge: challenge, participant: participant }
  let!(:admin) { create :participant, :admin }
  let!(:challenge_admin_participant) { create :challenge_participant, challenge: challenge, participant: admin }
  let!(:organizer) { create :participant, organizer: challenge.organizer }
  let!(:challenge_organizer_participant) { create :challenge_participant, challenge: challenge, participant: organizer }

  context 'download link' do
    it 'participant' do
      log_in(participant)
      visit challenge_dataset_files_path(challenge, wait: 1)
      expect(page).not_to have_link 'Delete'
    end

    it 'admin' do
      log_in(admin)
      visit challenge_dataset_files_path(challenge, wait: 1)
      expect(page).to have_link 'Delete'
    end

    it 'organizer' do
      log_in(organizer)
      visit challenge_dataset_files_path(challenge, wait: 1)
      expect(page).to have_link 'Delete'
    end
    # TODO after participant terms is fixed
    # scenario 'download file', js: true do
    #   log_in(admin)
    #   visit challenge_dataset_files_path(challenge, wait: 1)
    #   click_link 'first_file'
    #   expect(DatasetFileDownload.count).to eq(1)
    # end
  end
end
