local DataStoreKeyInfo = {}
DataStoreKeyInfo.__index = DataStoreKeyInfo

function DataStoreKeyInfo.new(createdTime, updatedTime, version, userIds, metadata)
	local userIdsType = typeof(userIds)

	if userIdsType ~= "nil" and userIdsType ~= "table" then
		error(`expected userIds to be a table or nil, got {userIdsType}`)
	end

	if userIdsType == "table" then
		local expectedKey = 1
		for key, value in userIds do
			assert(typeof(value) == "number", "userId must be a number")

			if key ~= expectedKey then
				error(`expected userIds to be an array, got invalid key: {key}`)
			end

			expectedKey += 1
		end
	end

	return setmetatable({
		CreatedTime = createdTime * 1000,
		UpdatedTime = updatedTime * 1000,
		Version = version,
		userIds = userIds or {},
		metadata = metadata or {},
	}, DataStoreKeyInfo)
end

function DataStoreKeyInfo:GetUserIds()
	return self.userIds
end

function DataStoreKeyInfo:GetMetadata()
	return self.metadata
end

return DataStoreKeyInfo
