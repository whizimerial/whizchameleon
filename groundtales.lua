-- =======================================================
-- Slope Snapping Script (Fall-Only Snapping)
-- =======================================================

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local vel = player:get_velocity()
        
        -- Adjust this threshold to taste. 
        -- A negative value ensures they are actually falling downwards 
        -- rather than just standing still or walking down a gentle slope.
        local fall_threshold = -0.5
        
        if vel.y < fall_threshold then
            local pos = player:get_pos()
            
            -- Cast a ray downwards to catch the slope below
            local from = {x = pos.x, y = pos.y + 0.3, z = pos.z}
            local to = {x = pos.x, y = pos.y - 0.6, z = pos.z} -- slightly deeper check for falling
            
            local ray = minetest.raycast(from, to, false, false)
            for pointed in ray do
                if pointed.type == "node" then
                    local node = minetest.get_node(pointed.under)
                    
                    -- Check if the node is your slope variant
                    if node.name:find("whizchameleon") and node.name:find("slope") then
                        local target_y = pointed.intersection_point.y
                        
                        -- If the slope surface is close beneath the player, snap their Y position
                        if target_y <= pos.y + 0.1 and target_y >= pos.y - 0.5 then
                            pos.y = target_y
                            player:set_pos(pos)
                            
                            -- Optional: Reset downward velocity slightly upon landing/snapping 
                            -- to prevent jarring bounces if desired:
                            -- player:set_velocity({x = vel.x, y = 0, z = vel.z})
                        end
                        break
                    end
                end
            end
        end
    end
end)
