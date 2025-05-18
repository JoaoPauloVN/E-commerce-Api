shared_examples "pagination_concern" do |factory_name|
  let!(:records) { create_list(factory_name, 20) }

  context "when :page and :length are empty" do
    let(:paginated_records) { described_class.paginate(nil, nil) }

    it "return the ten firsts records" do
      expect(paginated_records.count).to eq 10
    end

    it "matches the firsts records" do
      expect(paginated_records).to eq described_class.all[0..9]
    end
  end

  context "returns records from the second page" do
    let(:page) { 2 }
    let(:paginated_records) { described_class.paginate(page, nil) }

    it "return second page records" do
      expect(paginated_records.count).to eq 10
    end

    it "matches the second page records" do
      expect(paginated_records).to eq described_class.all[10..19]
    end
  end

  context "returns 15 records when :length is 15" do
    let(:length) { 15 }
    let(:paginated_records) { described_class.paginate(nil, length) }

    it "returns 15 records" do
      expect(paginated_records.count).to eq length
    end

    it "matches the 15 firsts records" do
      expect(paginated_records).to eq described_class.all[0..(length - 1)]
    end
  end

  context "returns the records for the second page with length 10" do
    let(:page) { 2 }
    let(:length) { 10 }
    let(:paginated_records) { described_class.paginate(page, length) }

    it "return second page records with :length" do
      expect(paginated_records.count).to eq length
    end

    it "matches the second page records" do
      expect(paginated_records).to eq described_class.all[length..(length * page - 1)]
    end
  end

  context "when :length exceeds the total number of records" do
    let(:length) { 25 }
    let(:paginated_records) { described_class.paginate(nil, length) }

    it "return 20 records" do
      expect(paginated_records.count).to eq records.count
    end

    it "matches the records" do
      expect(paginated_records).to eq described_class.all[0..(length - 1)]
    end
  end

  context "when page exceeds available records" do
    let(:length) { 25 }
    let(:page) { 2 }
    let(:paginated_records) { described_class.paginate(page, length) }

    it "returns an empty result" do
      expect(paginated_records.count).to eq 0
    end
  end

  context "when :page and :length are strings" do
    let(:paginated_records) { described_class.paginate("2", "5") }

    it "return 5 records" do
      expect(paginated_records.count).to eq 5
    end

    it "matches the records" do
      expect(paginated_records).to eq described_class.all[5..9]
    end
  end
end