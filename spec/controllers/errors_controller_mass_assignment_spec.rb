# frozen_string_literal: true

describe ErrorsController do
  describe "POST create" do
    it "does not allow submitted user_id to override the authenticated reporter" do
      reporter = user_factory
      other_user = user_factory
      user_session(reporter)

      post "create", params: {
        error: {
          message: "synthetic CWE-915 regression test",
          user_id: other_user.id
        }
      }

      expect(response).to be_redirect
      expect(ErrorReport.order(:id).last.user_id).to eq(reporter.id)
    end
  end
end
