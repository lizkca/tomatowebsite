require "application_system_test_case"

class TomatoesTest < ApplicationSystemTestCase
  setup do
    @tomato = tomatoes(:one)
  end

  test "visiting the index" do
    visit tomatoes_url
    assert_selector "h1", text: "Tomatoes"
  end

  test "should create tomato" do
    visit tomatoes_url
    click_on "New tomato"

    fill_in "Note", with: @tomato.note
    click_on "Create Tomato"

    assert_text "Tomato was successfully created"
    click_on "Back"
  end

  test "should update Tomato" do
    visit tomato_url(@tomato)
    click_on "Edit this tomato", match: :first

    fill_in "Note", with: @tomato.note
    click_on "Update Tomato"

    assert_text "Tomato was successfully updated"
    click_on "Back"
  end

  test "should destroy Tomato" do
    visit tomato_url(@tomato)
    accept_confirm { click_on "Destroy this tomato", match: :first }

    assert_text "Tomato was successfully destroyed"
  end
end
