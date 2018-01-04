-- 属性生成测试器

-- 属性类别
-- 万分比其实是有利于东西掉落几率UP，但是更利于运气属性挂钩设计
local atrType = 
{
    {type=1,name="HP血量",des="基础属性：生命值为0代表死亡"},
    {type=2,name="MP魔法",des="基础属性：释放技能所需要的能量"},
    {type=3,name="XP经验",des="当前得到的经验，升级等级相关"},
    {type=4,name="基础物理攻击",des="基础属性：物理类型攻击"},
    {type=5,name="基础魔法攻击",des="基础属性：魔法类型攻击"},
    {type=6,name="基础物理防御",des="基础属性：减免物理攻击伤害"},
    {type=7,name="基础魔法防御",des="基础属性：减免魔法攻击伤害"},
    {type=8,name="速度",des="基础属性：决定释放攻击技能"},
    {type=9,name="格挡",des="基础属性：直接减少对方物理伤害值"},
    {type=10,name="免疫",des="基础属性：直接减少攻击方的魔法伤害值"},
    {type=11,name="闪避",des="基础属性：防御方不受伤害几率，万分比"},
    {type=12,name="命中",des="基础属性：攻击方释放技能的几率，万分比"},
    {type=13,name="物理暴击",des="基础属性：攻击方物理攻击的暴击几率，万分比"},
    {type=14,name="魔法暴击",des="基础属性：攻击方魔法攻击的暴击几率，万分比"},
    {type=15,name="运气",des="基础属性：每次掉落极品物品几率UP，相当于掉落几率乘积因子，每个参数有个max值"},
    {type=16,name="增加经验值百分比",des="特殊属性：每次得到经验的时候增加，向上取整"},
    {type=17,name="增加金币百分比",des="特殊属性：每次得到金币的时候增加，向上取整"},
    {type=18,name="增加物理攻击百分比",des="特殊属性：基础物理攻击增加"},
    {type=19,name="增加魔法攻击百分比",des="特殊属性：基础魔法攻击增加"},
    {type=20,name="增加物理防御百分比",des="特殊属性：基础物理防御增加"},
    {type=21,name="增加魔法防御百分比",des="特殊属性：基础魔法防御增加"},
    {type=22,name="吸血",des="特殊属性：攻击对方回复HP"},
    {type=23,name="吸魔",des="特殊属性：攻击对方回复MP"},
}


-- 装备品质
-- 套装激活，套装需要单独弄
-- 品质决定随机出来的总系数
local equipQuality = 
{
    [1] = {name = "破旧的",color="灰色",ratio=0.8,},
    [2] = {name = "平庸的",color="白色",ratio=1,},
    [3] = {name = "精良的",color="绿色",ratio=1.2,},
    [4] = {name = "精密的",color="蓝色",ratio=1.5,},
    [5] = {name = "大师的",color="紫色",ratio=2,},
    [6] = {name = "传说的",color="橙色",ratio=2.5,},
    -- 套装单独使用
    [7] = {name = "xxx的",color="红色",ratio=2,},
}

-- 部件属性
-- 每个装备可能拥有的属性，比如衣服可能就没有攻击属性
-- 需要带入品质，有的属性只有高品质才会有
local equip = 
{
    [1] = 
    {
        pos=1,name="通用头盔",des="无职业区分：增加防御、命中、生命、魔法；特殊属性：格挡、免疫",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={1,6,7},speNum=0,speType={},},
        [2] = {num = 2,type={1,2,6,7},speNum=0,speType={},},
        [3] = {num = 3,type={1,2,6,7},speNum=0,speType={},},
        [4] = {num = 4,type={1,2,6,7,12},speNum=0,speType={},},
        [5] = {num = 4,type={1,2,6,7,12},speNum=1,speType={9,10},},
        [6] = {num = 5,type={1,2,6,7,12},speNum=2,speType={9,10},},
    },
    [2] = 
    {
        pos=2,name="通用衣服",des="无职业区分：增加防御、生命；特殊属性：增加物理防御百分比、增加魔法防御百分比",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={1,6,7},speNum=0,speType={},},
        [2] = {num = 2,type={1,6,7},speNum=0,speType={},},
        [3] = {num = 3,type={1,6,7},speNum=0,speType={},},
        [4] = {num = 4,type={1,6,7},speNum=0,speType={},},
        [5] = {num = 4,type={1,6,7},speNum=1,speType={20,21},},
        [6] = {num = 5,type={1,6,7},speNum=2,speType={20,21},},
    },
    [3] = 
    {
        pos=3,name="通用鞋子",des="无职业区分：闪避、增加防御；特殊属性：速度、XP",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={6,7},speNum=0,speType={},},
        [2] = {num = 2,type={6,7},speNum=0,speType={},},
        [3] = {num = 3,type={6,7},speNum=0,speType={},},
        [4] = {num = 4,type={6,7,11},speNum=0,speType={},},
        [5] = {num = 4,type={6,7,11},speNum=1,speType={8,16},},
        [6] = {num = 5,type={6,7,11},speNum=2,speType={8,16},},
    },
    [4] = 
    {
        pos=4,name="通用披风",des="无职业区分：增加防御、运气；特殊属性：物理暴击、魔法暴击",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={6,7},speNum=0,speType={},},
        [2] = {num = 2,type={6,7},speNum=0,speType={},},
        [3] = {num = 3,type={6,7,15},speNum=0,speType={},},
        [4] = {num = 4,type={6,7,15},speNum=0,speType={},},
        [5] = {num = 4,type={6,7,15},speNum=1,speType={13,14},},
        [6] = {num = 5,type={6,7,15},speNum=2,speType={13,14},},
    },
    [5] = 
    {
        pos=5,name="通用戒指",des="无职业区分：增加物理攻击百分比、增加魔法攻击百分比、物理暴击、魔法暴击；特殊属性：吸血、吸魔、增加金币百分比、增加经验值百分比",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={13,14,},speNum=0,speType={},},
        [2] = {num = 2,type={13,14,18},speNum=0,speType={},},
        [3] = {num = 2,type={13,14,18,19},speNum=1,speType={16,17,},},
        [4] = {num = 2,type={13,14,18,19},speNum=2,speType={16,17,},},
        [5] = {num = 2,type={13,14,18,19},speNum=3,speType={22,23,16,17},},
        [6] = {num = 2,type={13,14,18,19},speNum=4,speType={22,23,16,17},},
    },
    [6] = 
    {
        pos=6,name="通用大剑",des="物理职业：基础物理攻击、速度、命中、物理暴击、运气；特殊属性：吸血、吸魔、增加物理攻击百分比",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={4,8,12},speNum=0,speType={},},
        [2] = {num = 2,type={4,8,12,13},speNum=0,speType={},},
        [3] = {num = 3,type={4,8,12,13,15},speNum=0,speType={},},
        [4] = {num = 4,type={4,8,12,13,15},speNum=0,speType={},},
        [5] = {num = 4,type={4,8,12,13,15},speNum=1,speType={18,22},},
        [6] = {num = 5,type={4,8,12,13,15},speNum=2,speType={18,22,23},},
    },
    [7] = 
    {
        pos=7,name="通用法杖",des="魔法职业：基础魔法攻击、速度、命中、魔法暴击、运气；特殊属性：吸血、吸魔、增加魔法攻击百分比",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={5,8,12},speNum=0,speType={},},
        [2] = {num = 2,type={5,8,12,14},speNum=0,speType={},},
        [3] = {num = 3,type={5,8,12,14,15},speNum=0,speType={},},
        [4] = {num = 4,type={5,8,12,14,15},speNum=0,speType={},},
        [5] = {num = 4,type={5,8,12,14,15},speNum=1,speType={19,23},},
        [6] = {num = 5,type={5,8,12,14,15},speNum=2,speType={19,22,23},},
    },
    [8] = 
    {
        pos=8,name="通用匕首",des="物理职业：基础物理攻击、速度、命中、闪避、物理暴击、运气；特殊属性：吸血、吸魔、增加物理攻击百分比",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={4,8,12},speNum=0,speType={},},
        [2] = {num = 2,type={4,8,12,11},speNum=0,speType={},},
        [3] = {num = 3,type={4,8,12,11,15},speNum=0,speType={},},
        [4] = {num = 4,type={4,8,12,11,15},speNum=1,speType={13,18},},
        [5] = {num = 4,type={4,8,12,11,15},speNum=2,speType={18,22,13},},
        [6] = {num = 5,type={4,8,12,11,15},speNum=3,speType={18,22,23,13},},
    },
    
}


-- 每个属性的随机值区域
-- 如果想要直观点或者暴力可控制，每一个等级都手动配置，否则使用线性或者曲线公司来做
local range = 
{
    [1] = {min=1,max=10},
    [2] = {min=1,max=10},
    [3] = {min=0,max=0},
    [4] = {min=1,max=10},
    [5] = {min=1,max=10},
    [6] = {min=1,max=10},
    [7] = {min=1,max=10},
    [8] = {min=1,max=10},
    [9] = {min=1,max=10},
    [10] = {min=1,max=10},
    [11] = {min=1,max=10},
    [12] = {min=1,max=10},
    [13] = {min=1,max=10},
    [14] = {min=1,max=10},
    [15] = {min=1,max=10},
    [16] = {min=1,max=10},
    [17] = {min=1,max=10},
    [18] = {min=1,max=10},
    [19] = {min=1,max=10},
    [20] = {min=1,max=10},
    [21] = {min=1,max=10},
    [22] = {min=1,max=10},
    [23] = {min=1,max=10},
}


-- 属性上限
-- 可能数据设置不好还会引起很多问题，还是需要多多做防范，比如百分比的东西就不能多


-- 需要考虑的模式
-- 1:根据等级变化，根据品质变化
-- 2:根据材料合成变化

-- 模拟穿戴装备
local equips = {}

-- atrTypeList 随机的属性列表
-- level 如果要考虑等级因素，则需要配置等级系数：对应的玩法就是装备强化升级，得到属性系数叠加
-- ratio 品质系数
local function getRandomData(atrTypeList,ratio,level)
    level = level or 1
    local t = atrTypeList[math.random(1,#atrTypeList)]
            
    local data = range[t]
    if data then
        local d = math.random(data.min,data.max)
        d = math.ceil(d*ratio)
        return t,d
    end
    return t,'nil'
end

local function genEquip(type)
    local equipType = tonumber(type)
    if equipType then
        local e = equip[equipType]
        if e then
            print(e.name)
            print(e.des)
            -- 随机品质
            local eq = math.random(1,#equipQuality-1)
            -- for eq=1,#equipQuality-1 do
                print("品质"..eq..":["..equipQuality[eq].color.."]"..equipQuality[eq].name)
                local s = "获得属性:"
                -- 暂时存储属性，用于属性叠加
                local atrTmp = {}
                for j=1,e[eq].num do
                    local t,n = getRandomData(e[eq].type,equipQuality[eq].ratio)
                    if atrTmp[t] then
                        atrTmp[t] = atrTmp[t] + n
                    else
                        atrTmp[t] = n
                    end
                end

                for j=1,e[eq].speNum do
                    local t,n = getRandomData(e[eq].speType,equipQuality[eq].ratio)
                    if atrTmp[t] then
                        atrTmp[t] = atrTmp[t] + n
                    else
                        atrTmp[t] = n
                    end
                end

                for k,v in pairs(atrTmp) do
                    s = s..atrType[k].name..":"..v.."  "
                end
                
                print(s)
            -- end
            equips[equipType] = atrTmp
        else
            print("unkown equip :"..type)
        end
    else
        print("unkown equip :"..type)
    end
end


math.randomseed(os.time())
-- print("输入数字1-10进行装备生成，回车退出")
-- while(1) do
--     -- 获得输入
--     local readStr = io.read()
--     -- 处理输入
--     if #readStr==0 or readStr=="" then
--         return
--     end
    -- 处理生成装备
    for i=1,6 do
        genEquip(i)
    end
    -- 合并属性
    local tAtr = {}
    for k,v in pairs(equips) do
        for k1,v1 in pairs(v) do
            if tAtr[k1] then
                tAtr[k1] = tAtr[k1] + v1
            else
                tAtr[k1] = v1
            end
        end
    end
    
    local s = "装备总属性："
    print(s)
    for k,v in pairs(tAtr) do
        -- s = s..atrType[k].name..":"..v.."  "
        local ts = atrType[k].name..":"..v.."  "
        print(ts)
    end
    -- print(s)
-- end
