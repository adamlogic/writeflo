Version.where(permalink: Version::LANDING_PAGE_PERMALINK).all.each do |old_landing_page_version|
  old_landing_page_version.update_attribute :permalink, SecureRandom.hex(6)
end

landing_page_content = File.read('doc/landing_page_copy.txt')

doc = Doc.create!(content: landing_page_content)
doc.latest_version.update_attribute :permalink, Version::LANDING_PAGE_PERMALINK
