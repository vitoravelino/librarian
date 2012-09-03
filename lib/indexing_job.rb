require 'net/http'

class IndexingJob < Struct.new(:thesis)
  def perform
    tmp_file = extract_content(thesis)
    update_thesis(File.read(tmp_file))
    delete_file(tmp_file)
  end

  private
    def extract_content(thesis)
      original_file = Rails.root.join('public', 'uploads', "#{thesis.id}#{thesis.file}").to_s
      Docsplit.extract_text([original_file], :ocr => false, :output => 'public/uploads/')
      tmp_file = original_file.sub('.pdf', '.txt')

      tmp_file
    end

    def update_thesis(text)
      thesis.file = "#{thesis.id}#{thesis.file}"
      thesis.text = text
      thesis.save
      thesis.solr_index!
    end

    def delete_file(filename)
      File.delete(filename) if File.exists?(filename)
    end

end