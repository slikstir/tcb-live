RSpec::Matchers.define :have_case_insensitive_content do |expected|
  match do |page|
    page.has_content?(/#{Regexp.escape(expected)}/i)
  end

  failure_message do |page|
    "expected the page to have case-insensitive content matching '#{expected}'"
  end

  failure_message_when_negated do |page|
    "expected the page **not** to have case-insensitive content matching '#{expected}'"
  end
end
