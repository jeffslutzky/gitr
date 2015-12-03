FactoryGirl.define do
	factory:user do
		id "1"
		name "Ian Candy"
		email "candyman@candyland.org"
		uid	"0123456789"
		provider "github"
		association :admin
		association :collaborator
	end
end