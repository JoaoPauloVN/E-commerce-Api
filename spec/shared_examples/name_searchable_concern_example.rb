shared_examples "name_searchable_concern" do |factory_name|
  let!(:search_term) {"Example"}
  let!(:matching_records) do
    (0..2).map { |i| create(factory_name, name: "#{search_term} #{i}") }
  end
  let!(:non_matching_records) { create_list(factory_name, 3) }

  it "returns records matching the :name" do
    result = described_class.search_by_name(search_term)
    expect(result).to contain_exactly(*matching_records)
  end

  it "does not return records without a match in :name" do
    result = described_class.search_by_name(search_term)
    expect(result).not_to include(*non_matching_records)
  end
end