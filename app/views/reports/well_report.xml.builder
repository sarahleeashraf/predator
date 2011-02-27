xml.field_data() do
	for d in @days
		xml.data_point do
			xml.date(d[:date])
			xml.oil_amout(d[:oil_amount])
			xml.gas_amount(d[:gas_amount])
		end
	end
end