require 'net/http'

class IndexingJob < Struct.new(:thesis)
  def perform
    original_file = Rails.root.join('public', 'uploads', "#{thesis.id}#{thesis.file}").to_s
    Docsplit.extract_text([original_file], :ocr => false, :output => 'public/uploads/')
    tmp_file = original_file.sub('.pdf', '.txt')
    thesis.file = "#{thesis.id}#{thesis.file}"
    thesis.text = File.read(tmp_file)
    thesis.save
    thesis.solr_index!
    File.delete(tmp_file) if File.exists?(tmp_file)
  end

end