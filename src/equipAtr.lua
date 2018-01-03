-- 属性生成测试器

-- 属性类别
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
    {type=11,name="闪避",des="基础属性：防御方不受伤害几率"},
    {type=12,name="命中",des="基础属性：攻击方释放技能的几率"},
    {type=13,name="物理暴击",des="基础属性：攻击方物理攻击的暴击几率"},
    {type=14,name="魔法暴击",des="基础属性：攻击方魔法攻击的暴击几率"},
    {type=15,name="增加经验值百分比",des="特殊属性：每次得到经验的时候增加"},
    {type=16,name="增加物理攻击百分比",des="特殊属性：基础物理攻击增加"},
    {type=17,name="增加魔法攻击百分比",des="特殊属性：基础魔法攻击增加"},
    {type=18,name="增加物理防御百分比",des="特殊属性：基础物理防御增加"},
    {type=19,name="增加魔法防御百分比",des="特殊属性：基础魔法防御增加"},
    -- {type=20,name="",des=""},
}


-- 装备品质
-- 套装激活，套装需要单独弄
local equipQuality = 
{
    [1] = {name = "破旧的",color="灰色",},
    [2] = {name = "平庸的",color="白色",},
    [3] = {name = "精良的",color="绿色",},
    [4] = {name = "精密的",color="蓝色",},
    [5] = {name = "大师的",color="紫色",},
    [6] = {name = "传说的",color="橙色",},
    -- 套装单独使用
    [7] = {name = "xxx的",color="红色",},
}

-- 部件属性
-- 每个装备可能拥有的属性，比如衣服可能就没有攻击属性
-- 需要带入品质，有的属性只有高品质才会有
local equip = 
{
    [1] = 
    {
        pos=1,name="通用头盔",des="无职业区分：增加防御、命中、生命、魔法、格挡、免疫",
        -- 品质所具有的属性以及最大属性个数，属性相同可以累加，随机的时候，但是有的属性是唯一的，譬如免疫中毒这种玩意需要单独列出来
        -- num多少条属性，type属性类型,speNum特殊属性最多多少个，speType属性类型
        [1] = {num = 1,type={1,6,7},speNum=0,speType={},},
        [2] = {num = 2,type={1,2,6,7},speNum=0,speType={},},
        [3] = {num = 3,type={1,2,6,7},speNum=0,speType={},},
        [4] = {num = 4,type={1,2,6,7},speNum=0,speType={},},
        [5] = {num = 5,type={1,2,6,7},speNum=1,speType={9,10},},
        [6] = {num = 6,type={1,2,6,7},speNum=2,speType={9,10},},
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
}


-- 属性上限
-- 可能数据设置不好还会引起很多问题，还是需要多多做防范，比如百分比的东西就不能多


-- 需要考虑的模式
-- 1:根据等级变化，根据品质变化
-- 2:根据材料合成变化



local function getRandomData(atrTypeList,level)
    level = level or 1
    local t = atrTypeList[math.random(1,#atrTypeList)]
            
    local data = range[t]
    if data then
        local d = math.random(data.min,data.max)
        return t,d
    end
    return t,'nil'
end

local function genEquip(equipType)
    local equipType = tonumber(equipType)
    -- body
    local e = equip[equipType]
    if e then
        print(e.name)
        print(e.des)
        for i=1,#equipQuality-1 do
            print("品质"..i..":["..equipQuality[i].color.."]"..equipQuality[i].name)
            local s = "获得属性:"
            -- 暂时存储属性，用于属性叠加
            local atrTmp = {}
            for j=1,e[i].num do
                local t,n = getRandomData(e[i].type)
                if atrTmp[t] then
                    atrTmp[t] = atrTmp[t] + n
                else
                    atrTmp[t] = n
                end
            end

            for j=1,e[i].speNum do
                local t,n = getRandomData(e[i].speType)
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
        end
    else
        print("unkown equip :"..equipType)
    end
end


math.randomseed(os.time())
print("输入数字1-10进行装备生成，回车退出")
while(1) do
    -- 获得输入
    local readStr = io.read()
    -- 处理输入
    if #readStr==0 or readStr=="" then
        return
    end
    -- 处理生成装备
    genEquip(readStr)
end
