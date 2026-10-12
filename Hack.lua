local CONFIG = {
	AutoPlay      = true,          -- เลือกทีม + กดปุ่ม Play ที่หน้า Loading (ทำก่อนทุกอย่าง)
	Team          = "Floppa",      -- ทีมที่เลือก
	AutoPumpkin   = true,          -- เลเวล PumpkinMinLevel..PumpkinMaxLevel-1: เสก/ฆ่า Giant Pumpkin (ฟาร์ม Scary Skull เมื่อเสกไม่ออก)
	PumpkinMinLevel = 1100,
	PumpkinMaxLevel = 1200,        -- ถึงเลเวลนี้แล้วกลับไปฟาร์มเลเวลปกติ
	SummonPresses = 2,             -- กด E เสกบอสกี่รอบ (Pumpkin/Evil Noob/Lord Sus) แล้วเช็กสปอว์นทันที
	PumpkinSkullKills = 5,         -- ฆ่า Scary Skull กี่ตัวแล้วกลับไปเสก
	DebugSpawn    = false,         -- true = ตอนเริ่มพิมพ์/คัดลอกรายงานสปอว์นมอนทุกจุด (Enemy_Location)
	AntiLag       = true,          -- ลบพื้นผิว/เอฟเฟกต์/เงา ลดแลค
	Highlight     = true,          -- ไฮไลต์สีฟ้ารอบตัวละครตลอด
	ShowUI        = true,          -- แผงสถานะ (ซ้าย: เลเวล/เงิน/Gem ขวา: เช็กลิสต์ ทำเสร็จเป็นสีเขียว)
	AutoRedeem    = false,          -- Redeem โค้ดทั้งหมดก่อนเริ่มทำอย่างอื่น (รอจนเสร็จ)
	RedeemURL     = "https://pastebin.com/raw/2W4kMG3c", -- ดึงรายการโค้ดจาก raw (1 บรรทัด/โค้ด) ดึงไม่ได้ = ใช้รายการสำรองในสคริปต์
	RedeemOwnCode = true,          -- Redeem โค้ดของตัวเอง (เฉพาะเมื่อ LocalPlayer.Code เป็นค่าข้อความ ไม่ใช่โฟลเดอร์)
	AutoRaceV2    = true,          -- เลเวล RaceV2MinLevel+ และเผ่ายังเป็น V1 -> ทำเควส Sogga แล้วใช้ Awakening Orb
	RaceV2MinLevel = 500,
	AutoBossWatch = true,          -- เช็กบอสเกิดตลอด: เกิดแล้วหยุดทุกอย่างไปฟาร์มก่อน (ไม่แทรกกลางเรดที่กำลังสู้อยู่)
	MemeBeastMinLevel = 1500,      -- เลเวลนี้ขึ้นไปเช็ก Meme Beast
	GiantPumpkinWatchMinLevel = 1100, -- เลเวลนี้ขึ้นไปเช็ก Giant Pumpkin (รับเควสแล้วตี)
	AutoEvilNoob  = true,          -- เลเวล EvilNoobMinLevel+ : เควส Evil Noob (เสกเองถ้าไม่เกิด) จนได้ Yellow Blade
	EvilNoobMinLevel = 2000,
	EvilNoobMaxCycles = 3,         -- ทำ Evil Noob ครบกี่รอบแล้วยังไม่ได้ Yellow Blade -> ไปเรดจน Gem ถึง NoobRaidGems แล้วกลับมาทำดาบต่อ (0 = วนจนกว่าจะได้ ไม่ไปเรดก่อน)
	NoobRaidGems = 50000,          -- Gem เป้าหมายตอนไปเรดระหว่างรอพักทำดาบ (ถึงแล้วซื้อ Drop X2 แล้วกลับไปทำดาบ)
	AutoBuyDropX2 = true,          -- ซื้อ Gamepass Drop Item X2 ตอน Gem ถึง NoobRaidGems (ซื้อครั้งเดียว)
	DropX2GamepassId = 876020870,  -- GamepassId Drop Item X2 ที่ซื้อตอน Gem ถึง NoobRaidGems
	AutoBuyGemX2  = true,          -- ซื้อ Gamepass Gem x2 ตอน Gem ถึง GemX2Gems (ซื้อครั้งเดียว ก่อน Drop X2)
	GemX2Gems     = 30000,
	GemX2GamepassId = 86944271,    -- GamepassId Gem x2
	NoobCheckSeconds = 8,          -- กด E แล้ววาร์ปไปจุด Evil Noob รอเช็กสปอว์นสูงสุดกี่วินาที (บอสเกิดช้า + ต้องอยู่ใกล้ถึงจะโหลดมอน)
	EvilNoobSummonRounds = 30,     -- วนเสก/ไปฟาร์ม Moai สูงสุดกี่รอบต่อหนึ่งครั้งที่หามอนไม่เจอ
	MoaiKills = 5,                 -- ฟาร์ม Moai กี่ตัวต่อรอบ แล้วกลับไปเสกใหม่
	AutoRerollRace = true,         -- เผ่าที่อัพ V2 ไม่ได้ (Orb ไม่หายหลังใช้) -> เก็บ Orb แล้วไปรีเผ่า (Watermelon Man) แล้วลองใหม่
	RaceRerollMax = 30,            -- รีเผ่าได้สูงสุดกี่ครั้งก่อนหยุด
	AutoFlameKatana = true,        -- เลเวล FlameKatanaMinLevel+ : เอา Flame Katana ออกจากคลัง / ไม่มี -> ซื้อ / ซื้อแล้วยังไม่ได้ -> ไปตี Walter Dog แล้วทำซ้ำ
	FlameKatanaMinLevel = 250,
	FlameKatanaMaxCycles = 8,      -- วนซื้อ/ตี Walter Dog ได้สูงสุดกี่รอบก่อนยอมแพ้ (กันค้างไม่จบ)
	AutoBallerStyle = true,        -- เงินถึง BallerMoney -> ไปซื้อหมัด Baller ก่อนทุกอย่าง (ไม่มีในกระเป๋า -> ไปฟาร์ม Baller แล้วกลับมาซื้อวนจนได้)
	BallerMoney   = 10000000,      -- เงินขั้นต่ำที่จะเริ่มซื้อ
	UseBallerWhenOwned = true,     -- ได้ Baller แล้วใช้ Baller เป็นหมัดหลักทุกเลเวล
	BallerSkills  = true,          -- ถือ Baller: ใช้สกิล Z/X/C/V เมื่อพร้อม (กดปุ่มแบบเดิม หันกล้องไปที่มอน ไม่ยิงรีโมท)
	BallerKeys    = { "Z", "X", "C", "V" },
	BallerSkillRange = 120,        -- ใช้สกิลเมื่อมอนอยู่ในระยะนี้ (studs)
	BallerSkillGap   = 2.5,        -- ถ้าอ่านคูลดาวจาก GUI ไม่ได้ ใช้สกิลเดิมซ้ำห่างกันอย่างน้อยกี่วินาที
	BallerKills   = 10,            -- ฟาร์มมอน Baller กี่ตัวต่อรอบ แล้วกลับไปซื้อใหม่
	AutoHaki      = true,          -- เงินถึง AuraMoney -> ไปซื้อ Aura Master + เปิดฮาคิ (ซื้อไม่ได้ = รอบอส AuraBossName เกิด -> ไปตี -> กลับมาซื้อซ้ำ ระหว่างรอทำอย่างอื่น)
	AuraMoney     = 10000000,      -- เงินขั้นต่ำที่จะเริ่มซื้อ Aura Master
	AuraBossName  = "Meme Beast",  -- ชื่อบอสที่ต้องตีเพื่อซื้อ Aura Master
	AutoHakiKeepOn = true,         -- ซื้อแล้ว: ถ้าฮาคิหลุด (ตาย/รีสปอว์น) เปิดใหม่ให้เอง
	AutoHakiReroll = true,         -- ทำของ/ดาบครบ + มี Aura Master -> ไปสุ่มสีฮาคิที่ Halved Sorcerer ซ้ำจน Gem หมด (แผง HAKI COLOR REROLL โชว์สีที่ได้)
	HakiRerollWaitAll = true,      -- true = รอ Baller/Flame Katana/Yellow Blade/Pink Hammer/Banana/Purple Katana ครบก่อน / false = มี Aura Master + มี Gem ก็สุ่มเลย
	HakiRerollNPC = "Halved Sorcerer", -- อาร์กิวเมนต์ที่ส่งไปกับ Reroll_Color
	HakiRerollMinGems = 1,         -- Gem ขั้นต่ำก่อนเริ่มสุ่ม (หลังสุ่มครั้งแรกสคริปต์จำราคาสุ่มจาก Gem ที่ลดจริง)
	HakiRerollDelay = 0.6,         -- รอกี่วินาทีระหว่างการสุ่มแต่ละครั้ง
	HakiRerollRepeat = false,      -- true = Gem หมดแล้ว กลับไปเรดเก็บ Gem แล้วมาสุ่มต่อได้อีก / false = สุ่มจน Gem หมดรอบเดียวแล้วจบ
	AutoFarm      = true,          -- ฟาร์มเลเวลอัตโนมัติ (รับเควส + ตีมอนตามเลเวล)
	BringMob      = true,          -- ดึงมอนมารวมที่จุดฟาร์ม
	BringFruit    = true,          -- วาร์ปไปเก็บผลไม้ที่ดรอปบนพื้น
	AutoStore     = true,          -- เก็บผลไม้ที่ได้เข้าคลังอัตโนมัติ
	FruitFullRetrySeconds = 600,   -- เก็บผลไหนเข้าคลังไม่ได้ = คลังผลนั้นเต็ม -> ไม่เก็บ/ไม่เก็บจากพื้นผลนั้นกี่วินาที แล้วค่อยลองใหม่
	AutoStats     = true,          -- อัพสเตตัสอัตโนมัติ: Melee จนตัน (2400) แล้วสลับ Defense / Sword
	ResetIfStyleLost = true,       -- ถ้าหมัด/อาวุธที่ใช้ฟาร์มหายไป (เกมบัค) ให้รีตัวละครอัตโนมัติ
	AutoRaid      = true,          -- เลเวลถึง RaidMinLevel (2000) -> Auto Join + Auto Raid (หยุดเมื่อ Gem ถึง RaidStopGems)
	RaidMinLevel  = 2000,
	RaidStopGems  = 20000,
	AutoStartRaid = false,         -- false = ไม่ส่ง StartRaid เอง ไปยืนรอที่จุดเข้าเรดเฉยๆ / true = ส่ง Start ตาม RaidStartDelay + RaidStartRetry
	RaidStartDelay = 3,            -- ยืนที่จุดเข้าเรดครบกี่วินาที แล้วค่อยส่ง Start (ส่งซ้ำตาม RaidStartRetry จนเรดเริ่ม)
	RaidStartRetry = 1,            -- ส่ง Start แล้วเรดยังไม่เริ่ม -> ส่งซ้ำทุกกี่วินาที
	RaidOnlyNewMobs = true,        -- ในเรดตีเฉพาะมอนที่เกิดใหม่หลังเรดเริ่ม (ไม่ตีมอนข้างนอกที่มีอยู่ก่อน) / ยังไม่มีมอนเรด -> ลอยรอ
	RaidNoMobResetSeconds = 5,     -- รอครบ RaidFarmDelay แล้วยังไม่เจอมอนเรดเลยกี่วินาที -> ฆ่าตัวตายรีตัวละคร (เรดบัค) / 0 = ปิด
	RaidFarmDelay = 11,            -- เรดเริ่ม (RaidGui ขึ้น) แล้วรอกี่วินาทีก่อนเริ่มตีมอน (ลอยรออยู่เฉยๆ ไม่โจมตี)
	RaidTargetRange = 1000,        -- ในเรดเลือกตีเฉพาะมอนที่อยู่ห่างไม่เกินกี่ studs
	RaidReturn    = true,          -- Join เรดแล้ว (RaidGui ขึ้น) ถ้าตัวละครไม่ได้อยู่ตำแหน่งเรด -> เทเลพอตกลับไปจุดเรดอัตโนมัติ (รวมถึงตายแล้วเกิดใหม่)
	RaidReturnDistance = 500,      -- ห่างจุดเรดเกินกี่ studs ถือว่า "ไม่ได้อยู่ตำแหน่งเรด" (ต้องมากกว่าระยะที่ใช้ตีมอนในเรด)
	RaidFolderHeight = 5,          -- ตอนวาร์ปไปที่ของใน workspace.Raids ให้ยกสูงขึ้นกี่ studs (กันจมพื้น)
	RaidArenaPos  = nil,           -- (ไม่บังคับ) พิกัดจุดเรด เช่น {1234, 56, -789} / nil = สคริปต์จำเองตอน Join เรดครั้งแรก (ดูพิกัดจาก Output แล้วเอามาใส่ได้)
	RaidSmart     = true,          -- โหมดเอาตัวรอดใน Raid (เลือกเป้าฉลาด/ยืนห่างเมื่อถูกรุม/ถอยฟื้นเลือด)
	RaidRetreatHp = 0.45,          -- เลือดต่ำกว่านี้ (สัดส่วน) -> ถอยขึ้นที่สูง
	RaidResumeHp  = 0.85,          -- ฟื้นถึงเท่านี้ -> กลับไปสู้
	RaidOrbitRadius = 20,          -- ตอนถอย: วิ่งวนเป็นวงกลมรัศมีเท่านี้ (หลบสกิลมอน)
	RaidOrbitSpeed  = 8,           -- ความเร็ววน (เรเดียน/วินาที) 8 ≈ 1.3 รอบ/วินาที
	AutoBuy       = true,          -- ซื้อของอัตโนมัติเมื่อเงินถึงเกณฑ์ (ดูรายการที่ SHOP_LIST)
	Weapon        = "FightingStyle", -- "FightingStyle" | "Power" | "Weapon"
	Method        = "Upper",       -- "Upper" | "Behind" | "Below"
	Distance      = 8,             -- ระยะห่างจากมอน
	RaidCrowdDistance = 0,         -- มอนรุมเยอะ (>=5) ในเรดให้ยืนห่างเท่านี้ / 0 = ไม่ถอยห่าง ใช้ Distance เดิม (ไม่ขยาย hitbox แล้ว ถ้าห่างเกินหมัดจะไม่โดน)
	FollowSmooth  = 20,            -- (เฉพาะในเรด) ทำให้ตัวละครตามมอนนุ่มขึ้น กันพุ่งไปมาตอนมอนกระเด็น/ความเร็วกระตุก / 0 = ปิด
	RaidGapHold   = 1.5,           -- ตีมอนตัวหนึ่งเสร็จแล้วยังไม่เจอตัวต่อไป: ยืนรอที่เดิมกี่วินาทีก่อนค่อยลอยรอ (กันขึ้นๆลงๆ ระหว่างเวฟ)
	RaidFreezeMob = true,          -- ในเรด: ล็อกความเร็วมอนที่กำลังตีให้นิ่งทุกเฟรม (กันมอนพุ่ง/กระเด็นไปมา)
	FollowLead    = 0.08,          -- ตามมอนล่วงหน้ากี่วินาที (คำนวณจากความเร็วมอน กันวาร์ปตามไม่ทัน) / 0 = ปิด
	BringRange    = 250,           -- รัศมีดึงมอน
	MaxBringMobs  = 3,             -- จำนวนมอนที่ดึงสูงสุด
	BringSpread   = 2,             -- ระยะที่กระจายมอนรอบจุดฟาร์ม (แต่ละตัวอยู่คนละจุด)
	BringOrbitSpeed = 2,           -- มอนที่ถูกดึงมาหมุนรอบจุดฟาร์ม (เรเดียน/วินาที 2 ≈ 0.3 รอบ/วินาที, 0 = ไม่หมุน)
	-- ===== Item Quests: Pink Hammer / Banana / Purple Katana (ทำต่อจาก Flame Katana / Race V2 / Evil Noob) =====
	UseSwordSkills = true,         -- มีดาบที่ซื้อแล้ว -> ถือดาบดีสุดตีด้วย + ใช้สกิล Z/X ตอนไม่คูลดาว (คูลดาวทั้งคู่ -> สลับกลับไปใช้หมัด)
	MaxLevel      = 2400,          -- เลเวลสูงสุดของเกม
	SwordOnlyAtMax = true,         -- ถึง MaxLevel แล้วไม่ว่าฟาร์มอะไรถือดาบอย่างเดียว (ไม่สลับไปหมัด) ใช้สกิล Z/X เมื่อไม่คูลดาว
	SwordRotateInRaid = true,      -- LvMax + ในเรด: ดาบเล่มนี้คูลดาวทั้ง Z/X -> สลับไปดาบอีกเล่มที่พร้อมใช้สกิลทันที วนไปเรื่อย ๆ
	SwordSwapSettle = 0.12,        -- สลับดาบแล้วรอกี่วินาทีให้ GUI คูลดาวอัปเดต ก่อนเช็ก (ยิ่งน้อยยิ่งสลับไว)
	SwordCdSample = 0.1,           -- เช็กคูลดาว: อ่านขนาดแถบ 2 ครั้งห่างกันกี่วินาที (ขยับ = คูลดาว)
	SwordRotateBlock = 1.0,        -- ดาบที่เพิ่งคูลดาวทั้งคู่ ข้ามไปกี่วินาทีก่อนกลับมาเช็กใหม่
	SwordRetrySeconds = 1.5,       -- สลับไปหมัดแล้วรอกี่วินาทีก่อนลองสลับกลับมาเช็กคูลดาวดาบ
	SwordPriority = { "Purple Katana", "Yellow Blade", "Pink Hammer", "Banana", "Flame Katana" },   -- ดีสุด -> รองลงไป
	ResetIfHitStuck = true,        -- ตีมอนแล้วเลือดมอนไม่ลดนาน StuckSeconds วินาที -> ฆ่าตัวตายรีตัวละคร (กันบัค)
	StuckSeconds    = 3,
	AutoItemQuests = true,         -- เปิด/ปิดเควสไอเทมทั้ง 3 อัน (ก่อนเริ่มจะเอาออกจากคลังมาเช็กก่อนทุกอัน)
	PinkHammerMinLevel = 1350,     -- เลเวลขั้นต่ำทำ Pink Hammer (ฟาร์ม Pink Absorber)
	BananaMinLevel = 800,          -- เลเวลขั้นต่ำทำ Banana (ซื้อ Smiling Cat / ไม่ได้ -> ฟาร์ม Gorilla King)
	BananaMinMoney = 350000,       -- เงินขั้นต่ำที่ต้องมีก่อนเริ่มทำ Banana
	PurpleKatanaMinLevel = 1700,   -- เลเวลขั้นต่ำทำ Purple Katana (Lord Sus)
	LordSusSummonRounds = 30,      -- วนเสก/ไปฟาร์ม Sus Duck สูงสุดกี่รอบต่อหนึ่งครั้งที่หา Lord Sus ไม่เจอ
	SusDuckKills = 9,              -- ฟาร์ม Sus Duck กี่ตัวต่อรอบ แล้วกลับไปเสกใหม่
	ItemQuestMaxCycles = 0,        -- วนซ้ำสูงสุดกี่รอบต่อไอเทม (0 = วนจนกว่าจะได้)
	-- ===== AFK / กันบัค =====
	AntiAFK       = true,          -- กันโดนเตะเพราะ AFK (Idled + ขยับจำลองทุก ๆ AntiAFKInterval วินาที)
	AntiAFKInterval = 120,
	AutoRecover   = true,          -- ลูป/เธรดไหน Error กลางคัน -> รีสตาร์ทเธรดนั้นเองอัตโนมัติ (ไม่ทำให้สคริปต์หยุด)
	RecoverMaxRestarts = 200,      -- รีสตาร์ทเธรดเดียวได้สูงสุดกี่ครั้ง (ถ้ารันนานเกิน 30 วิ ถือว่าปกติ นับใหม่)
	AutoRejoin    = true,          -- หลุดเซิร์ฟ/ขึ้นหน้าต่าง Error -> เข้าเกมเดิมใหม่อัตโนมัติ
	RejoinScript  = "",            -- (ไม่บังคับ) โค้ดที่จะรันหลังรีจอยผ่าน queue_on_teleport เช่น loadstring(game:HttpGet("URL"))()  ถ้าใช้ Auto Execute ของ executor ปล่อยว่างได้
}

repeat task.wait() until game:IsLoaded()

-- ===================== Runtime: Anti-AFK / Auto Recover / Auto Rejoin =====================
-- ส่วนนี้อยู่นอกตัวสคริปต์หลัก ต่อให้สคริปต์หลัก Error ก็ยังทำงานต่อ
local _spawn, _wait, _cancel = task.spawn, task.wait, task.cancel
local _LP = game:GetService("Players").LocalPlayer

-- รันสคริปต์ซ้ำ -> เก็บกวาดของรอบเก่าก่อน (เธรด/คอนเนกชัน) กันทำงานซ้อน
_G.__MemeSeaGen = (_G.__MemeSeaGen or 0) + 1
local MY_GEN = _G.__MemeSeaGen
for _, th in ipairs(_G.__MemeSeaThreads or {}) do if _cancel then pcall(_cancel, th) end end
for _, cn in ipairs(_G.__MemeSeaConns or {}) do pcall(function() cn:Disconnect() end) end
_G.__MemeSeaThreads, _G.__MemeSeaConns = {}, {}
local function KeepConn(cn) table.insert(_G.__MemeSeaConns, cn) return cn end

-- task.spawn แบบกันตาย: ถ้าฟังก์ชัน Error -> พิมพ์เตือนแล้วรันใหม่เอง (ฟังก์ชันที่จบปกติจะไม่ถูกรันซ้ำ)
local function ResilientSpawn(fn, ...)
	local args = table.pack(...)
	local th = _spawn(function()
		local restarts = 0
		while MY_GEN == _G.__MemeSeaGen do
			local t0 = tick()
			local ok, err = xpcall(function() return fn(table.unpack(args, 1, args.n)) end, debug.traceback)
			if ok then return end
			if not CONFIG.AutoRecover then warn("[Recover] Error (ปิด AutoRecover):", err) return end
			if tick() - t0 > 30 then restarts = 0 end   -- เคยรันปกติ >30 วิ -> ไม่นับว่าพังรัว
			restarts = restarts + 1
			warn(string.format("[Recover] เธรด Error -> รีสตาร์ท (%d/%d)\n%s", restarts, CONFIG.RecoverMaxRestarts, tostring(err)))
			if restarts >= CONFIG.RecoverMaxRestarts then warn("[Recover] เธรดนี้พังรัวเกินกำหนด หยุดเธรดนี้") return end
			_wait(math.min(0.5 + restarts * 0.25, 5))
		end
	end)
	if th then table.insert(_G.__MemeSeaThreads, th) end
	return th
end
-- ใช้ task.spawn แบบกันตายทั้งไฟล์ (task.wait/อื่น ๆ ใช้ของเดิมผ่าน __index)
local task = setmetatable({ spawn = ResilientSpawn }, { __index = task })

-- ===== Anti-AFK =====
if CONFIG.AntiAFK then
	local VU = game:GetService("VirtualUser")
	local function Nudge()
		pcall(function()
			VU:CaptureController()
			VU:ClickButton2(Vector2.new(0, 0))
		end)
	end
	KeepConn(_LP.Idled:Connect(Nudge))
	_spawn(function()
		while MY_GEN == _G.__MemeSeaGen do
			_wait(CONFIG.AntiAFKInterval or 120)
			Nudge()
		end
	end)
	print("[AntiAFK] เปิดใช้งาน")
end

-- ===== Auto Rejoin (หลุดเซิร์ฟ / ขึ้นหน้าต่าง Error) =====
if CONFIG.AutoRejoin then
	local TeleportService = game:GetService("TeleportService")
	local rejoining = false
	local function Rejoin(reason)
		if rejoining then return end
		rejoining = true
		warn("[Rejoin] " .. tostring(reason) .. " -> เข้าเกมใหม่")
		if CONFIG.RejoinScript ~= "" and queue_on_teleport then pcall(queue_on_teleport, CONFIG.RejoinScript) end
		for _ = 1, 40 do
			pcall(function() TeleportService:Teleport(game.PlaceId, _LP) end)
			_wait(10)
		end
		rejoining = false
	end
	pcall(function()
		local overlay = game:GetService("CoreGui"):WaitForChild("RobloxPromptGui", 10):WaitForChild("promptOverlay", 10)
		KeepConn(overlay.ChildAdded:Connect(function(c)
			if c.Name == "ErrorPrompt" then Rejoin("ErrorPrompt") end
		end))
	end)
	pcall(function()
		KeepConn(game:GetService("GuiService").ErrorMessageChanged:Connect(function(msg)
			if msg and msg ~= "" then Rejoin("ErrorMessage: " .. tostring(msg)) end
		end))
	end)
	pcall(function()
		KeepConn(TeleportService.TeleportInitFailed:Connect(function()
			rejoining = false
			_wait(3)
			Rejoin("TeleportInitFailed")
		end))
	end)
end

-- ===== ตัวสคริปต์หลักอยู่ในฟังก์ชันนี้ ถ้า Error ระดับบนสุด จะเก็บกวาดแล้วรันใหม่ (สูงสุด 5 รอบ) =====
local function __MemeSeaMain()

-- ===================== Auto Play (เลือกทีม + กดปุ่ม Play) =====================
-- ทำก่อนทุกอย่าง เพราะตัวละครจะยังไม่เกิดจนกว่าจะกด Play
if CONFIG.AutoPlay then
	local Players0 = game:GetService("Players")
	local VIM0 = game:GetService("VirtualInputManager")
	local GuiService0 = game:GetService("GuiService")
	local pg = Players0.LocalPlayer:WaitForChild("PlayerGui")

	local function GetPlay()
		local g = pg:FindFirstChild("LoadingGui")
		local bg = g and g:FindFirstChild("PlayBackground")
		return bg and bg:FindFirstChild("Play"), g
	end

	-- รอหน้า Loading โผล่ (สูงสุด ~10 วินาที) ถ้าไม่มีแปลว่าเข้าเกมแล้ว ข้ามไป
	local playBtn = GetPlay()
	if not playBtn then
		pcall(function()
			local g = pg:WaitForChild("LoadingGui", 10)
			local bg = g and g:WaitForChild("PlayBackground", 5)
			if bg then bg:WaitForChild("Play", 5) end
		end)
		playBtn = GetPlay()
	end

	if playBtn then
		-- 1) เลือกทีม
		pcall(function()
			game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent", 10)
				:WaitForChild("MainEvents", 10):WaitForChild("TeamChoose", 10)
				:FireServer(CONFIG.Team)
		end)
		task.wait(1)

		-- 2) กดปุ่ม Play จริง (ลองซ้ำจนกว่าหน้า Loading จะหาย สูงสุด 10 รอบ)
		local function StillLoading()
			local btn, g = GetPlay()
			return btn ~= nil and g.Enabled and btn.Visible and btn.Parent.Visible
		end
		for attempt = 1, 10 do
			if not StillLoading() then break end
			pcall(function()
				local btn = GetPlay()
				local pos, size = btn.AbsolutePosition, btn.AbsoluteSize
				local x, y
				if attempt <= 2 then
					-- สูตรตำแหน่งเดิมที่ใช้ได้
					x = pos.X + size.X / 1
					y = pos.Y + size.Y / 2 + 50
				else
					-- สำรอง: กลางปุ่ม (บวก GuiInset)
					x = pos.X + size.X / 2
					y = pos.Y + size.Y / 2 + GuiService0:GetGuiInset().Y
				end
				VIM0:SendMouseButtonEvent(x, y, 0, true, game, 1)
				task.wait(0.05)
				VIM0:SendMouseButtonEvent(x, y, 0, false, game, 1)
			end)
			task.wait(1.5)
		end
	end
end

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
repeat task.wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

_G.AutoFarm = CONFIG.AutoFarm
_G.BringMonster = CONFIG.BringMob
_G.SelectWeapon = CONFIG.Weapon
_G.Method = CONFIG.Method
_G.DistanceMob = CONFIG.Distance
_G.BringRange = CONFIG.BringRange
_G.MaxBringMobs = CONFIG.MaxBringMobs
_G.BringSpread = CONFIG.BringSpread
_G.BringOrbitSpeed = CONFIG.BringOrbitSpeed

local StartMagnet, PosMon, Mon, Mob, FrameQ, MethodFarm
local FruitBusy = false
local ShopBusy = false
local StoreBusy = false     -- กำลังเก็บผลไม้เข้าคลัง (ต้องถือผลไม้ ห้ามแย่งถือหมัด)
local Delta = LocalPlayer.Name

-- ===================== ลดแลค (ลบพื้นผิว) + ไฮไลต์ตัวละคร =====================
if CONFIG.AntiLag then
	local Lighting0 = game:GetService("Lighting")

	local function Optimize(v)
		if v:IsA("Terrain") then return end
		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
			v.CastShadow = false
			if v:IsA("MeshPart") then v.TextureID = "" end
		elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("SurfaceAppearance") then
			v:Destroy()
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam")
			or v:IsA("Smoke") or v:IsA("Fire") or v:IsA("Sparkles") then
			v.Enabled = false
		elseif v:IsA("PostEffect") then           -- Blur / Bloom / SunRays / ColorCorrection / DepthOfField
			v.Enabled = false
		elseif v:IsA("Atmosphere") then
			v.Density = 0; v.Haze = 0; v.Glare = 0
		end
	end

	-- ของที่เกิดใหม่ทีหลัง (มอน เอฟเฟกต์สกิล ฯลฯ) ก็ลดให้อัตโนมัติ
	workspace.DescendantAdded:Connect(function(v)
		task.defer(function() pcall(Optimize, v) end)
	end)
	Lighting0.DescendantAdded:Connect(function(v)
		task.defer(function() pcall(Optimize, v) end)
	end)

	task.spawn(function()
		pcall(function()
			Lighting0.GlobalShadows = false
			Lighting0.FogEnd = 9e9
		end)
		pcall(function()
			local t = workspace.Terrain
			t.WaterWaveSize = 0; t.WaterWaveSpeed = 0; t.WaterReflectance = 0
			if t:FindFirstChildOfClass("Clouds") then t:FindFirstChildOfClass("Clouds").Enabled = false end
		end)
		pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)

		-- ไล่ลดของที่มีอยู่แล้ว แบ่งเป็นชุดๆ กันจอค้าง
		local list = workspace:GetDescendants()
		for i, v in ipairs(list) do
			pcall(Optimize, v)
			if i % 400 == 0 then task.wait() end
		end
		for _, v in ipairs(Lighting0:GetDescendants()) do pcall(Optimize, v) end
		print("[AntiLag] ลดแลคเสร็จ")
	end)
end

if CONFIG.Highlight then
	local function ApplyHighlight(char)
		if not char then return end
		local old = char:FindFirstChild("SeiHighlight")
		if old then old:Destroy() end
		local h = Instance.new("Highlight")
		h.Name = "SeiHighlight"
		h.FillColor = Color3.fromRGB(45, 170, 255)
		h.OutlineColor = Color3.fromRGB(130, 215, 255)
		h.FillTransparency = 0.5
		h.OutlineTransparency = 0
		h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		h.Adornee = char
		h.Parent = char
	end

	ApplyHighlight(LocalPlayer.Character)
	LocalPlayer.CharacterAdded:Connect(function(c)
		task.wait(0.5)
		ApplyHighlight(c)
	end)
	-- กันถูกลบ: เช็กทุก 2 วินาที ถ้าหายให้สร้างใหม่
	task.spawn(function()
		while task.wait(2) do
			local c = LocalPlayer.Character
			if c and not c:FindFirstChild("SeiHighlight") then
				pcall(ApplyHighlight, c)
			end
		end
	end)
end

-- ===================== Status UI (แผงสถานะ) =====================
-- ซ้าย: Level / Gem / เงิน / Race   ขวา: รายการซื้อของ (จุดเรืองแสงสีเขียวเมื่อซื้อสำเร็จ)
-- ล่าง: สถานะที่กำลังทำอยู่   ปุ่มโลโก้: แตะเพื่อเปิด/ปิด ลากเพื่อย้ายได้
local HUB_NAME = "XH HUB"
local LOGO_ASSET = "rbxassetid://99118312841228"
local Checklist = {}
local StatusOverride, CurrentShopItem
_G.XH_Auto = true   -- Master switch: bật/tắt toàn bộ auto (nút trên bảng)

function SetDone(key) Checklist[key] = true end
function SetLive(key, v) Checklist[key] = v and true or nil end   -- แถวสถานะสด: เขียว/เทา ตามค่าปัจจุบัน

local function Fmt(n)
	local str = tostring(math.floor(tonumber(n) or 0))
	local out = str:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

-- อ่านเงินจากข้อความใน GUI (รองรับ "$ 39,323" และตัวย่อ K/M/B)
local function ParseAmount(text)
	if not text then return nil end
	local t = string.upper((string.gsub(text, "[,%s$]", "")))
	local num, suf = string.match(t, "^(%d+%.?%d*)([KMBT]?)")
	if not num then num, suf = string.match(t, "(%d+%.?%d*)([KMBT]?)") end
	num = tonumber(num)
	if not num then return nil end
	local mult = ({ K = 1e3, M = 1e6, B = 1e9, T = 1e12 })[suf] or 1
	return num * mult
end

function ReadMoney()
	local ok, v = pcall(function()
		return ParseAmount(LocalPlayer.PlayerGui.MainGui.CurrencyFrame_Mobile.Money.Text)
	end)
	return ok and v or nil
end

-- รายการที่แสดงทางขวา = ของที่ซื้อเท่านั้น (key ต้องตรงกับ name ใน SHOP_LIST)
local UI_ROWS = {}
if CONFIG.AutoBallerStyle then
	table.insert(UI_ROWS, { "Fighting Style: Baller", "Baller Style" })
end
if CONFIG.AutoHaki then
	table.insert(UI_ROWS, { "Ability: Aura Master", "Haki" })   -- เขียว = ซื้อแล้ว (เช็กจาก AuraColor_Folder)
end
if CONFIG.AutoBuy then
	table.insert(UI_ROWS, { "Upgrade Quest: Popcat", "Popcat Quest" })
	table.insert(UI_ROWS, { "Ability: Giga Chad", "Giga Chad" })
end
if CONFIG.AutoFlameKatana then
	table.insert(UI_ROWS, { "Weapon: Flame Katana", "Flame Katana" })
end
if CONFIG.AutoBuy then
	table.insert(UI_ROWS, { "Weapon: Hanger", "Hanger" })
	table.insert(UI_ROWS, { "Weapon: Doge", "Doge" })
end
if CONFIG.AutoEvilNoob then
	table.insert(UI_ROWS, { "Weapon: Yellow Blade", "Yellow Blade" })
end
if CONFIG.AutoItemQuests then   -- ต่อจากไอเทมเดิม (เลื่อนดูได้)
	table.insert(UI_ROWS, { "Weapon: Pink Hammer", "Pink Hammer" })
	table.insert(UI_ROWS, { "Weapon: Banana", "Banana" })
	table.insert(UI_ROWS, { "Weapon: Purple Katana", "Purple Katana" })
end

local function CurrentStatus()
	if not _G.XH_Auto then return "ĐÃ TẮT AUTO" end
	if StatusOverride then return StatusOverride end
	if ShopBusy then return "Đang mua: " .. tostring(CurrentShopItem or "") end
	if FruitBusy then return "Đang nhặt trái" end
	if StoreBusy then return "Đang cất trái" end
	if _G.Boss then return _G.BossStatus or "Boss" end
	if _G.Baller then return _G.BallerStatus or "Baller Style" end
	if _G.Aura then return _G.AuraStatus or "Auto Haki" end
	if _G.HakiReroll then return "Đang random màu Haki" end
	if _G.FlameKatana then return _G.FlameStatus or "Flame Katana" end
	if _G.RaceV2 then return _G.RaceV2Status or "Race V2" end
	if _G.EvilNoob then return _G.EvilNoobStatus or "Evil Noob" end
	if _G.ItemQuest then return _G.ItemQuestStatus or "Item Quest" end
	if _G.Pumpkin and not _G.Raid then return _G.PumpkinStatus or "Sự kiện Pumpkin" end
	if _G.Raid then
		local ok, vis = pcall(function() return LocalPlayer.PlayerGui.RaidGui.RaidFrame.Visible end)
		return (ok and vis) and "Đang Raid" or "Đang chờ Raid"
	end
	if _G.AutoFarm then return "Đang farm level" end
	return "Chờ"
end

local function CreateStatusUI()
	local UIS = game:GetService("UserInputService")
	local C = {
		bg1    = Color3.fromRGB(16, 21, 38),
		bg2    = Color3.fromRGB(9, 12, 22),
		card   = Color3.fromRGB(20, 27, 48),
		row    = Color3.fromRGB(24, 32, 56),
		line   = Color3.fromRGB(36, 46, 76),
		gray   = Color3.fromRGB(120, 132, 168),
		text   = Color3.fromRGB(205, 213, 235),
		white  = Color3.fromRGB(240, 244, 255),
		blue   = Color3.fromRGB(70, 190, 255),
		violet = Color3.fromRGB(125, 120, 255),
		green  = Color3.fromRGB(70, 235, 130),
		off    = Color3.fromRGB(58, 66, 94),
	}

	local gui = Instance.new("ScreenGui")
	gui.Name = "XHHubStatusUI"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 999
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
	local parented = false
	pcall(function()
		gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
		parented = true
	end)
	if not parented then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	-- ---------- helpers ----------
	local function corner(obj, r)
		local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r); c.Parent = obj
		return c
	end
	local function stroke(obj, color, th, tr)
		local s = Instance.new("UIStroke")
		s.Color = color; s.Thickness = th or 1; s.Transparency = tr or 0
		s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		s.Parent = obj
		return s
	end
	local function frame(parent, x, y, w, h, color)
		local f = Instance.new("Frame")
		f.Position = UDim2.fromOffset(x, y); f.Size = UDim2.fromOffset(w, h)
		f.BackgroundColor3 = color; f.BorderSizePixel = 0
		f.Parent = parent
		return f
	end
	local function label(parent, text, size, color, x, y, w, h, font, align)
		local t = Instance.new("TextLabel")
		t.BackgroundTransparency = 1
		t.Text = text; t.TextSize = size; t.TextColor3 = color
		t.Font = font or Enum.Font.Gotham
		t.TextXAlignment = align or Enum.TextXAlignment.Left
		t.Position = UDim2.fromOffset(x, y); t.Size = UDim2.fromOffset(w, h)
		t.Parent = parent
		return t
	end
	local function fitText(t, maxSize)
		t.TextScaled = true
		local c = Instance.new("UITextSizeConstraint"); c.MaxTextSize = maxSize; c.MinTextSize = 8; c.Parent = t
	end
	local function card(parent, x, y, w, h)
		local f = frame(parent, x, y, w, h, C.card)
		corner(f, 10); stroke(f, C.line, 1, 0.35)
		return f
	end

	-- ---------- ตัวแผงหลัก ----------
	local W, H = 500, 340
	local main = frame(gui, 0, 0, W, H, C.bg1)
	main.AnchorPoint = Vector2.new(0.5, 0.5)
	main.Position = UDim2.fromScale(0.5, 0.5)
	main.Active = true
	corner(main, 16)
	local g = Instance.new("UIGradient")
	g.Color = ColorSequence.new(C.bg1, C.bg2); g.Rotation = 90; g.Parent = main
	local mStroke = stroke(main, C.violet, 1.5, 0.55)
	local sg = Instance.new("UIGradient")
	sg.Color = ColorSequence.new(C.blue, C.violet); sg.Rotation = 30; sg.Parent = mStroke

	local scale = Instance.new("UIScale"); scale.Parent = main
	local function fit()
		local cam = workspace.CurrentCamera
		if not cam then return end
		local v = cam.ViewportSize
		scale.Scale = math.min(1, (v.X * 0.92) / W, (v.Y * 0.88) / H)
	end
	fit()
	if workspace.CurrentCamera then
		workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit)
	end

	-- ---------- หัวข้อ ----------
	local logo = Instance.new("ImageLabel")
	logo.BackgroundTransparency = 1; logo.Image = LOGO_ASSET
	logo.Position = UDim2.fromOffset(18, 10); logo.Size = UDim2.fromOffset(30, 30)
	logo.ScaleType = Enum.ScaleType.Fit; logo.Parent = main
	local title = label(main, "", 16, C.white, 56, 12, 420, 26, Enum.Font.GothamBold)
	title.RichText = true
	title.Text = '<font color="rgb(150,160,255)">' .. HUB_NAME .. '</font>  <font color="rgb(120,132,168)">CHÍNH</font>'

	local div = frame(main, 18, 48, W - 36, 2, C.blue)
	local dg = Instance.new("UIGradient")
	dg.Color = ColorSequence.new(C.blue, C.violet)
	dg.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.2), NumberSequenceKeypoint.new(0.7, 0.75), NumberSequenceKeypoint.new(1, 1),
	})
	dg.Parent = div
	corner(div, 1)

	-- ---------- Trái: thẻ thống kê ----------
	local lvCard = card(main, 18, 60, 224, 84)
	label(lvCard, "CẤP ĐỘ", 11, C.gray, 14, 8, 100, 14, Enum.Font.GothamMedium)
	local levelV = label(lvCard, "-", 40, C.blue, 14, 24, 196, 52, Enum.Font.GothamBold)
	fitText(levelV, 42)
	local lg = Instance.new("UIGradient")
	lg.Color = ColorSequence.new(C.blue, C.violet); lg.Parent = levelV

	local gemCard = card(main, 18, 152, 108, 56)
	label(gemCard, "GEM", 11, C.gray, 12, 7, 90, 14, Enum.Font.GothamMedium)
	local gemV = label(gemCard, "-", 18, C.white, 12, 24, 90, 24, Enum.Font.GothamBold)
	fitText(gemV, 18)

	local moneyCard = card(main, 134, 152, 108, 56)
	label(moneyCard, "TIỀN", 11, C.gray, 12, 7, 90, 14, Enum.Font.GothamMedium)
	local moneyV = label(moneyCard, "-", 18, C.green, 12, 24, 90, 24, Enum.Font.GothamBold)
	fitText(moneyV, 18)

	local raceCard = card(main, 18, 216, 224, 54)
	label(raceCard, "TỘC", 11, C.gray, 14, 7, 80, 14, Enum.Font.GothamMedium)
	local raceV = label(raceCard, "-", 18, C.white, 14, 24, 196, 24, Enum.Font.GothamBold)
	fitText(raceV, 18)

	-- ---------- Phải: danh sách vật phẩm ----------
	label(main, "VẬT PHẨM", 11, C.gray, 258, 60, 100, 14, Enum.Font.GothamMedium)
	local itemsCard = card(main, 250, 78, 232, 192)
	-- Danh sách cuộn được (kéo lên/xuống trong khung VẬT PHẨM)
	local scroller = Instance.new("ScrollingFrame")
	scroller.Name = "ItemsScroll"
	scroller.BackgroundTransparency = 1; scroller.BorderSizePixel = 0
	scroller.Position = UDim2.fromOffset(0, 4); scroller.Size = UDim2.new(1, 0, 1, -8)
	scroller.CanvasSize = UDim2.fromOffset(0, 8 + #UI_ROWS * 36)
	scroller.ScrollingDirection = Enum.ScrollingDirection.Y
	scroller.ScrollBarThickness = 4
	scroller.ScrollBarImageColor3 = C.violet
	scroller.ScrollBarImageTransparency = 0.2
	scroller.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
	scroller.Active = true        -- รับอินพุตเอง ไม่ให้ลากแผงหลักตอนเลื่อนรายการ
	scroller.Parent = itemsCard
	local rows = {}
	for i, r in ipairs(UI_ROWS) do
		local y = 4 + (i - 1) * 36
		local row = frame(scroller, 8, y, 210, 32, C.row); corner(row, 8)

		local halo = frame(row, 0, 0, 30, 30, C.green)       -- แสงเรืองรอบจุด
		halo.AnchorPoint = Vector2.new(0.5, 0.5); halo.Position = UDim2.fromOffset(22, 16)
		halo.BackgroundTransparency = 1; corner(halo, 15)

		local dot = frame(row, 0, 0, 10, 10, C.off)
		dot.AnchorPoint = Vector2.new(0.5, 0.5); dot.Position = UDim2.fromOffset(22, 16)
		corner(dot, 5)
		local ring = stroke(dot, C.green, 2, 1)               -- วงแสงรอบจุด

		label(row, r[2], 14, C.text, 42, 0, 160, 32, Enum.Font.GothamMedium)
		rows[r[1]] = { dot = dot, halo = halo, ring = ring, done = false }
	end
	if #UI_ROWS == 0 then
		label(itemsCard, "Tự mua: TẮT", 13, C.gray, 14, 8, 200, 24)
	end

	-- ---------- Thanh trạng thái + nút Bật/Tắt Auto ----------
	local bar = card(main, 18, 282, W - 36, 40)
	label(bar, "TT", 11, C.gray, 10, 0, 28, 40, Enum.Font.GothamMedium)
	frame(bar, 40, 12, 1, 16, C.line)
	local sHalo = frame(bar, 0, 0, 22, 22, C.green)
	sHalo.AnchorPoint = Vector2.new(0.5, 0.5); sHalo.Position = UDim2.fromOffset(62, 20)
	sHalo.BackgroundTransparency = 0.8; corner(sHalo, 11)
	local sDot = frame(bar, 0, 0, 8, 8, C.green)
	sDot.AnchorPoint = Vector2.new(0.5, 0.5); sDot.Position = UDim2.fromOffset(62, 20); corner(sDot, 4)
	local statusV = label(bar, "...", 13, C.white, 80, 0, W - 36 - 200, 40, Enum.Font.GothamMedium)

	-- Nút bật/tắt Auto (trên bảng)
	local autoBtn = Instance.new("TextButton")
	autoBtn.Name = "AutoToggle"
	autoBtn.AutoButtonColor = false
	autoBtn.BackgroundColor3 = C.green
	autoBtn.BorderSizePixel = 0
	autoBtn.Size = UDim2.fromOffset(90, 28)
	autoBtn.Position = UDim2.fromOffset(W - 36 - 100, 6)
	autoBtn.Font = Enum.Font.GothamBold
	autoBtn.TextSize = 13
	autoBtn.TextColor3 = C.white
	autoBtn.Text = "AUTO: BẬT"
	autoBtn.Parent = bar
	corner(autoBtn, 8)
	stroke(autoBtn, C.white, 1, 0.5)

	local function UpdateAutoBtn()
		if _G.XH_Auto then
			autoBtn.Text = "AUTO: BẬT"
			autoBtn.BackgroundColor3 = C.green
		else
			autoBtn.Text = "AUTO: TẮT"
			autoBtn.BackgroundColor3 = Color3.fromRGB(220, 70, 70)
		end
	end
	UpdateAutoBtn()

	autoBtn.MouseButton1Click:Connect(function()
		_G.XH_Auto = not _G.XH_Auto
		UpdateAutoBtn()
		if not _G.XH_Auto then
			-- Tắt toàn bộ chế độ auto
			_G.AutoFarm = false
			_G.Raid = false
			_G.GoRaid = false
			_G.Pumpkin = false
			_G.RaceV2 = false
			_G.FlameKatana = false
			_G.EvilNoob = false
			_G.ItemQuest = false
			_G.Boss = false
			_G.Baller = false
			_G.Aura = false
			_G.HakiReroll = false
			StartMagnet = false
			HoverOrigin = nil
			StatusOverride = "ĐÃ TẮT AUTO"
			print("[XH HUB] Đã TẮT toàn bộ Auto")
		else
			StatusOverride = nil
			_G.AutoFarm = CONFIG.AutoFarm
			print("[XH HUB] Đã BẬT lại Auto")
		end
	end)

	-- ---------- ปุ่มเปิด/ปิด (ลากได้) ----------
	local toggle = Instance.new("TextButton")
	toggle.Name = "ToggleUI"
	toggle.Text = ""; toggle.AutoButtonColor = false
	toggle.BackgroundColor3 = C.bg1; toggle.BorderSizePixel = 0
	toggle.Size = UDim2.fromOffset(54, 54)
	local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(800, 400)
	toggle.Position = UDim2.fromOffset(math.floor(vp.X * 0.108), math.floor(vp.Y * 0.23))
	toggle.Parent = gui
	corner(toggle, 14)
	local tStroke = stroke(toggle, C.violet, 1.5, 0.35)
	local tsg = Instance.new("UIGradient"); tsg.Color = ColorSequence.new(C.blue, C.violet); tsg.Rotation = 45; tsg.Parent = tStroke
	local tg = Instance.new("UIGradient"); tg.Color = ColorSequence.new(C.bg1, C.bg2); tg.Rotation = 90; tg.Parent = toggle
	local tLogo = Instance.new("ImageLabel")
	tLogo.BackgroundTransparency = 1; tLogo.Image = LOGO_ASSET
	tLogo.AnchorPoint = Vector2.new(0.5, 0.5)
	tLogo.Position = UDim2.fromScale(0.5, 0.5); tLogo.Size = UDim2.fromScale(0.7, 0.7)
	tLogo.ScaleType = Enum.ScaleType.Fit; tLogo.Parent = toggle

	-- ลากแบบคำนวณจาก "ระยะที่นิ้วเลื่อน" (delta) ไม่ใช้ AbsolutePosition จึงไม่กระโดด
	-- ย้ายตามนิ้วทันทีตั้งแต่พิกเซลแรก / แตะเฉยๆ (ขยับ <= 8px) ถือว่าเป็นการกด
	local function makeDraggable(obj, uiScale, onTap, clamp)
		local dragging, moved, dragStart, startPos = false, false, nil, nil
		obj.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				dragging, moved = true, false
				dragStart = input.Position
				startPos = obj.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
						if onTap and not moved then onTap() end
					end
				end)
			end
		end)
		UIS.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch) then
				local d = input.Position - dragStart
				if d.Magnitude > 8 then moved = true end
				local k = uiScale and uiScale.Scale or 1       -- UIScale คูณ offset อยู่ ต้องหารกลับ
				local x = startPos.X.Offset + d.X / k
				local y = startPos.Y.Offset + d.Y / k
				if clamp then
					local cam = workspace.CurrentCamera
					local v = cam and cam.ViewportSize or Vector2.new(800, 400)
					x = math.clamp(x, 0, v.X - obj.AbsoluteSize.X)
					y = math.clamp(y, 0, v.Y - obj.AbsoluteSize.Y)
				end
				obj.Position = UDim2.new(startPos.X.Scale, x, startPos.Y.Scale, y)
			end
		end)
	end

	makeDraggable(toggle, nil, function() main.Visible = not main.Visible end, true)
	makeDraggable(main, scale, nil, false)

	-- ---------- อัปเดตข้อมูล ----------
	local function refresh(instant)
		pcall(function()
			local d = LocalPlayer.PlayerData
			levelV.Text = Fmt(d.Level.Value)
			gemV.Text = Fmt(d.Gem.Value)
		end)
		local money = ReadMoney()
		if money then moneyV.Text = "$ " .. Fmt(money) end
		pcall(function()
			local _, rv, txt = ReadRace()
			if txt and txt ~= "" then raceV.Text = txt end
			raceV.TextColor3 = (rv == 2) and C.green or C.white   -- V2 -> เขียว
		end)
		for key, r in pairs(rows) do
			if not Checklist[key] and r.done then      -- แถวสถานะสด (Haki) ที่กลับเป็นปิด
				r.done = false
				r.dot.BackgroundColor3 = C.off
				r.dot.Size = UDim2.fromOffset(10, 10)
				r.ring.Transparency = 1
			elseif Checklist[key] and not r.done then
				r.done = true
				if instant then
					r.dot.BackgroundColor3 = C.green
					r.dot.Size = UDim2.fromOffset(12, 12)
					r.ring.Transparency = 0.45
				else
					local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad)
					TweenService:Create(r.dot, ti, { BackgroundColor3 = C.green, Size = UDim2.fromOffset(12, 12) }):Play()
					TweenService:Create(r.ring, ti, { Transparency = 0.45 }):Play()
				end
			end
		end
		statusV.Text = CurrentStatus()
	end

	refresh(true)
	task.spawn(function()
		while task.wait(0.5) do
			if not gui.Parent then break end
			refresh()
		end
	end)

	-- แสงเรืองกะพริบเบาๆ ของจุดที่ซื้อเสร็จแล้ว + จุดสถานะ
	task.spawn(function()
		while task.wait(0.05) do
			if not gui.Parent then break end
			local pulse = (math.sin(os.clock() * 3) + 1) / 2          -- 0..1
			for _, r in pairs(rows) do
				if r.done then
					r.halo.BackgroundTransparency = 0.68 + 0.2 * pulse
				end
			end
			sHalo.BackgroundTransparency = 0.7 + 0.2 * pulse
		end
	end)
end

-- รายการที่เคยซื้อแล้ว (จากไฟล์เซฟ) -> ให้เป็นสีเขียวตั้งแต่เปิดแผง ไม่ต้องรอระบบซื้อเริ่ม
pcall(function()
	local file = "MemeSea_Purchased_" .. LocalPlayer.UserId .. ".json"
	if isfile and readfile and isfile(file) then
		local saved = game:GetService("HttpService"):JSONDecode(readfile(file))
		for name in pairs(saved) do SetDone(name) end
	end
end)

-- ===================== Bảng PHỤ: bật/tắt từng tính năng riêng =====================
local function CreateFeatureUI()
	local UIS = game:GetService("UserInputService")
	local C = {
		bg1 = Color3.fromRGB(16, 21, 38), bg2 = Color3.fromRGB(9, 12, 22), card = Color3.fromRGB(20, 27, 48),
		row = Color3.fromRGB(24, 32, 56), line = Color3.fromRGB(36, 46, 76), gray = Color3.fromRGB(120, 132, 168),
		text = Color3.fromRGB(205, 213, 235), white = Color3.fromRGB(240, 244, 255),
		blue = Color3.fromRGB(70, 190, 255), violet = Color3.fromRGB(125, 120, 255),
		green = Color3.fromRGB(70, 235, 130), red = Color3.fromRGB(220, 70, 70), off = Color3.fromRGB(58, 66, 94),
	}
	local function corner(obj, r) local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r); c.Parent = obj end
	local function stroke(obj, color, th, tr)
		local s = Instance.new("UIStroke"); s.Color = color; s.Thickness = th or 1; s.Transparency = tr or 0
		s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.Parent = obj; return s
	end
	local function frame(parent, x, y, w, h, color)
		local f = Instance.new("Frame"); f.Position = UDim2.fromOffset(x, y); f.Size = UDim2.fromOffset(w, h)
		f.BackgroundColor3 = color; f.BorderSizePixel = 0; f.Parent = parent; return f
	end
	local function label(parent, text, size, color, x, y, w, h, font, align)
		local t = Instance.new("TextLabel"); t.BackgroundTransparency = 1; t.Text = text; t.TextSize = size
		t.TextColor3 = color; t.Font = font or Enum.Font.Gotham
		t.TextXAlignment = align or Enum.TextXAlignment.Left
		t.Position = UDim2.fromOffset(x, y); t.Size = UDim2.fromOffset(w, h); t.Parent = parent; return t
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "XHHubFeatureUI"; gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true
	gui.DisplayOrder = 997; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
	local parented = false
	pcall(function() gui.Parent = (gethui and gethui()) or game:GetService("CoreGui"); parented = true end)
	if not parented then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	local W, H = 280, 420
	local main = frame(gui, 0, 0, W, H, C.bg1)
	main.AnchorPoint = Vector2.new(0, 0.5)
	local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(800, 400)
	main.Position = UDim2.fromOffset(12, math.floor(vp.Y * 0.5))
	main.Active = true
	corner(main, 14)
	local g = Instance.new("UIGradient"); g.Color = ColorSequence.new(C.bg1, C.bg2); g.Rotation = 90; g.Parent = main
	stroke(main, C.violet, 1.5, 0.55)

	label(main, "XH HUB  •  PHỤ", 14, C.white, 14, 10, 250, 22, Enum.Font.GothamBold)
	local div = frame(main, 14, 36, W - 28, 2, C.blue)
	local dg = Instance.new("UIGradient"); dg.Color = ColorSequence.new(C.blue, C.violet); dg.Parent = div

	-- Danh sách tính năng có thể bật/tắt riêng
	local FEATURES = {
		{ key = "AutoFarm",       label = "Auto Farm Level",     get = function() return CONFIG.AutoFarm end,       set = function(v) CONFIG.AutoFarm = v; if not v then _G.AutoFarm = false end; if v and _G.XH_Auto then _G.AutoFarm = true end end },
		{ key = "AutoRaid",       label = "Auto Raid",           get = function() return CONFIG.AutoRaid end,       set = function(v) CONFIG.AutoRaid = v; if not v then _G.Raid = false; _G.GoRaid = false end end },
		{ key = "AutoPumpkin",    label = "Auto Pumpkin",        get = function() return CONFIG.AutoPumpkin end,    set = function(v) CONFIG.AutoPumpkin = v; if not v then _G.Pumpkin = false end end },
		{ key = "AutoEvilNoob",   label = "Auto Evil Noob",      get = function() return CONFIG.AutoEvilNoob end,   set = function(v) CONFIG.AutoEvilNoob = v; if not v then _G.EvilNoob = false end end },
		{ key = "AutoFlameKatana",label = "Auto Flame Katana",   get = function() return CONFIG.AutoFlameKatana end,set = function(v) CONFIG.AutoFlameKatana = v; if not v then _G.FlameKatana = false end end },
		{ key = "AutoRaceV2",     label = "Auto Race V2",        get = function() return CONFIG.AutoRaceV2 end,     set = function(v) CONFIG.AutoRaceV2 = v; if not v then _G.RaceV2 = false end end },
		{ key = "AutoBallerStyle",label = "Auto Baller",         get = function() return CONFIG.AutoBallerStyle end,set = function(v) CONFIG.AutoBallerStyle = v; if not v then _G.Baller = false end end },
		{ key = "AutoHaki",       label = "Auto Haki",           get = function() return CONFIG.AutoHaki end,       set = function(v) CONFIG.AutoHaki = v; if not v then _G.Aura = false; _G.AuraTask = nil end end },
		{ key = "AutoHakiReroll", label = "Auto Random Haki",    get = function() return CONFIG.AutoHakiReroll end, set = function(v) CONFIG.AutoHakiReroll = v; if not v then _G.HakiReroll = false end end },
		{ key = "AutoItemQuests", label = "Auto Item Quests",    get = function() return CONFIG.AutoItemQuests end, set = function(v) CONFIG.AutoItemQuests = v; if not v then _G.ItemQuest = false end end },
		{ key = "AutoBossWatch",  label = "Auto Boss Watch",     get = function() return CONFIG.AutoBossWatch end,  set = function(v) CONFIG.AutoBossWatch = v; if not v then _G.Boss = false end end },
		{ key = "BringMob",       label = "Bring Mob",           get = function() return CONFIG.BringMob end,       set = function(v) CONFIG.BringMob = v; _G.BringMonster = v end },
		{ key = "AutoStats",      label = "Auto Stats",          get = function() return CONFIG.AutoStats end,      set = function(v) CONFIG.AutoStats = v end },
		{ key = "AntiLag",        label = "Anti Lag",            get = function() return CONFIG.AntiLag end,        set = function(v) CONFIG.AntiLag = v end },
	}

	local scroller = Instance.new("ScrollingFrame")
	scroller.BackgroundTransparency = 1; scroller.BorderSizePixel = 0
	scroller.Position = UDim2.fromOffset(10, 48); scroller.Size = UDim2.new(1, -20, 1, -60)
	scroller.CanvasSize = UDim2.fromOffset(0, 8 + #FEATURES * 34)
	scroller.ScrollBarThickness = 4; scroller.ScrollBarImageColor3 = C.violet
	scroller.ScrollingDirection = Enum.ScrollingDirection.Y; scroller.Active = true
	scroller.Parent = main

	for i, feat in ipairs(FEATURES) do
		local y = 4 + (i - 1) * 34
		local row = frame(scroller, 0, y, W - 30, 30, C.row); corner(row, 8)
		label(row, feat.label, 13, C.text, 10, 0, 160, 30, Enum.Font.GothamMedium)

		local btn = Instance.new("TextButton")
		btn.AutoButtonColor = false; btn.BorderSizePixel = 0
		btn.Size = UDim2.fromOffset(60, 22); btn.Position = UDim2.fromOffset(W - 30 - 70, 4)
		btn.Font = Enum.Font.GothamBold; btn.TextSize = 12; btn.TextColor3 = C.white
		btn.Parent = row; corner(btn, 6)

		local function refreshBtn()
			local on = feat.get()
			btn.Text = on and "BẬT" or "TẮT"
			btn.BackgroundColor3 = on and C.green or C.red
		end
		refreshBtn()

		btn.MouseButton1Click:Connect(function()
			local newVal = not feat.get()
			feat.set(newVal)
			refreshBtn()
			print("[XH HUB][PHỤ]", feat.label, newVal and "BẬT" or "TẮT")
		end)
	end

	-- Kéo thả bảng PHỤ
	do
		local dragging, dragStart, startPos = false, nil, nil
		main.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging, dragStart, startPos = true, input.Position, main.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then dragging = false end
				end)
			end
		end)
		UIS.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local d = input.Position - dragStart
				main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end)
	end

	-- Nút ẩn/hiện bảng PHỤ
	local toggle = Instance.new("TextButton")
	toggle.Name = "ToggleFeatureUI"; toggle.Text = ""; toggle.AutoButtonColor = false
	toggle.BackgroundColor3 = C.bg1; toggle.BorderSizePixel = 0
	toggle.Size = UDim2.fromOffset(44, 44)
	toggle.Position = UDim2.fromOffset(12, math.floor(vp.Y * 0.5) + 220)
	toggle.Parent = gui; corner(toggle, 12)
	stroke(toggle, C.violet, 1.5, 0.35)
	local tLogo = Instance.new("TextLabel")
	tLogo.BackgroundTransparency = 1; tLogo.Text = "PHỤ"; tLogo.TextSize = 12
	tLogo.Font = Enum.Font.GothamBold; tLogo.TextColor3 = C.white
	tLogo.Size = UDim2.fromScale(1, 1); tLogo.Parent = toggle
	toggle.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
end

if CONFIG.ShowUI then
	task.spawn(function() pcall(CreateStatusUI) end)
	task.spawn(function() pcall(CreateFeatureUI) end)
end

-- ===================== Redeem Code (ทำก่อนทุกอย่าง) =====================
-- โค้ดนี้รันแบบ synchronous: ฟาร์ม / Bring / ซื้อของ จะยังไม่เริ่มจนกว่า Redeem จะเสร็จครบทุกโค้ด
local REDEEM_FALLBACK = {   -- ใช้เมื่อดึงจาก RedeemURL ไม่ได้เลย
	"100KFavorites", "100KLikes", "100MVisits", "100KActive",
	"70KActive", "Update4", "10KLikes", "10KMembers",
}

-- ดึงรายการโค้ดจาก raw (1 บรรทัด/โค้ด หรือคั่นด้วย , ; เว้นวรรค / ตัดคอมเมนต์หลัง -- หรือ #)
local function FetchRedeemCodes()
	local url = CONFIG.RedeemURL
	if type(url) ~= "string" or url == "" then return nil end
	for attempt = 1, 3 do
		local body
		pcall(function() body = game:HttpGet(url) end)
		if type(body) ~= "string" or body == "" then
			pcall(function()
				local req = request or http_request or (syn and syn.request)
				if req then
					local r = req({ Url = url, Method = "GET" })
					body = r and r.Body
				end
			end)
		end
		if type(body) == "string" and body ~= "" then
			local list, seen = {}, {}
			for line in body:gmatch("[^\r\n]+") do
				line = line:gsub("%-%-.*$", ""):gsub("#.*$", "")
				for tok in line:gmatch("[^%s,;]+") do
					if not seen[tok:lower()] then
						seen[tok:lower()] = true
						table.insert(list, tok)
					end
				end
			end
			if #list > 0 then return list end
		end
		task.wait(1)
	end
	return nil
end

-- โค้ดที่ Redeem แล้วจะไปโผล่ใน LocalPlayer.Code (เก็บทั้งชื่อลูกและค่าของลูก) -> ใช้เช็กว่าใส่ไปแล้ว/สำเร็จจริงไหม
local function RedeemedSet()
	local set = {}
	pcall(function()
		local folder = game:GetService("Players").LocalPlayer:FindFirstChild("Code")
		if not folder then return end
		for _, ch in ipairs(folder:GetChildren()) do
			set[ch.Name:lower()] = true
			if ch:IsA("ValueBase") and type(ch.Value) == "string" then set[ch.Value:lower()] = true end
			local av = ch:GetAttribute("Value")
			if type(av) == "string" then set[av:lower()] = true end
		end
		if folder:IsA("ValueBase") and type(folder.Value) == "string" then set[folder.Value:lower()] = true end
	end)
	return set
end

if CONFIG.AutoRedeem then
	local ok, codeRemote = pcall(function()
		return game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent", 15)
			:WaitForChild("MainEvents", 15):WaitForChild("Code", 15)
	end)
	if ok and codeRemote then
		pcall(function() game:GetService("Players").LocalPlayer:WaitForChild("Code", 10) end)   -- รอโฟลเดอร์โค้ดโหลดก่อนเช็ก
		StatusOverride = "Đang lấy danh sách code"
		local codes = FetchRedeemCodes()
		if codes then
			print("[Redeem] Lấy code từ raw được", #codes, "code")
		else
			codes = REDEEM_FALLBACK
			warn("[Redeem] Không lấy được code từ RedeemURL -> dùng danh sách dự phòng")
		end
		for i, code in ipairs(codes) do
			StatusOverride = string.format("Đang redeem code (%d/%d)", i, #codes)
			if RedeemedSet()[code:lower()] then
				print("[Redeem]", code, "ใส่แล้ว (มีใน LocalPlayer.Code) ข้าม")
			else
				local success, result = pcall(function()
					return codeRemote:InvokeServer(code)   -- InvokeServer จะรอจนเซิร์ฟเวอร์ตอบกลับ
				end)
				-- ยืนยัน: ใส่สำเร็จจริงต้องไปโผล่ใน LocalPlayer.Code
				local confirmed = false
				local t0 = tick()
				while tick() - t0 < 3 do
					if RedeemedSet()[code:lower()] then confirmed = true break end
					task.wait(0.2)
				end
				print("[Redeem]", code, success and "SENT" or "FAIL", confirmed and "CONFIRMED" or "ไม่พบใน LocalPlayer.Code (ใช้ไม่ได้/หมดอายุ/ชื่อไม่ตรง)", success and tostring(result) or "")
				task.wait(0.5)
			end
		end
		-- โค้ดของตัวเอง: เฉพาะกรณี LocalPlayer.Code เป็นค่าข้อความ (ถ้าเป็นโฟลเดอร์เก็บโค้ดที่ใส่แล้ว จะข้าม)
		if CONFIG.RedeemOwnCode then
			local own
			pcall(function()
				local c = game:GetService("Players").LocalPlayer:FindFirstChild("Code")
				if c and c:IsA("ValueBase") then own = c.Value
				elseif c and not c:IsA("Folder") then own = c:GetAttribute("Value") end
			end)
			if type(own) == "string" and own ~= "" and not RedeemedSet()[own:lower()] then
				StatusOverride = "Đang redeem code riêng"
				local success, result = pcall(function() return codeRemote:InvokeServer(own) end)
				print("[Redeem] own code", own, success and "OK" or "FAIL", success and tostring(result) or "")
			end
		end
	else
		warn("[Redeem] ไม่พบ Remote Code ข้ามขั้นตอนนี้")
	end
	StatusOverride = nil
end

-- ===================== เลือกโหมดเริ่มต้น (ก่อนเริ่มลูปฟาร์ม) =====================
-- ถ้าเลเวล/Gem เข้าเงื่อนไข Raid ให้เริ่มในโหมด Raid เลย ไม่ปล่อยให้ Auto Farm Level วาร์ปไปฟาร์มก่อน
-- ===== วิธีสำรองเช็คเผ่า V2 (เผื่อ GUI/ข้อความเกมบัค อ่าน V# ไม่ได้) =====
-- เปิดสกิลเผ่า (RaceSkill) แล้วดู CooldownGui.Container.RaceAbility_Template.Cooldown.Size
--   Size ขยับ = เผ่า V2 ทำงาน -> V2   |  ไม่เจอโฟลเดอร์ -> เปิดสกิลใหม่อีกรอบ  |  ยังไม่เจอ/Size นิ่ง -> ยังเป็น V1
local RaceProbe = { busy = false, last = 0, ver = nil }

local function RaceCooldownObj()
	local ok, obj = pcall(function()
		return game:GetService("Players").LocalPlayer.PlayerGui.CooldownGui.Container.RaceAbility_Template.Cooldown
	end)
	return ok and obj or nil
end

local function FireRaceSkill()
	pcall(function()
		game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent", 3)
			:WaitForChild("SkillEvents", 3):WaitForChild("Movement", 3):FireServer("RaceSkill")
	end)
end

-- ===== สัญญาณที่ 2: เสียง Sound_Effect.Race (SoundId 1295448103) ดังตอนสกิลเผ่า V2 ทำงาน =====
local RACE_SOUND_ID = "1295448103"

local function IsRaceSound(snd)
	if not snd:IsA("Sound") then return false end
	if string.find(tostring(snd.SoundId), RACE_SOUND_ID, 1, true) then return true end
	return snd.Name == "Race" and snd.Parent ~= nil and snd.Parent.Name == "Sound_Effect"
end

-- เริ่มดักเสียงก่อนกดสกิล: ซาวด์เดิมที่ถูก Play ใหม่ หรือซาวด์ที่ถูกสร้าง/โคลนมาแล้วเล่น -> hit
local function NewRaceSoundWatcher()
	local hit, conns = false, {}
	local function hook(snd, fresh)
		if fresh and snd.IsPlaying then hit = true end
		table.insert(conns, snd.Played:Connect(function() hit = true end))
		table.insert(conns, snd:GetPropertyChangedSignal("Playing"):Connect(function()
			if snd.Playing then hit = true end
		end))
	end
	local roots = { workspace, game:GetService("SoundService"), game:GetService("ReplicatedStorage"), game:GetService("Players").LocalPlayer }
	for _, root in ipairs(roots) do
		pcall(function()
			for _, d in ipairs(root:GetDescendants()) do
				if IsRaceSound(d) then pcall(hook, d, false) end
			end
			table.insert(conns, root.DescendantAdded:Connect(function(d)
				if IsRaceSound(d) then pcall(hook, d, true) end
			end))
		end)
	end
	return {
		hit = function() return hit end,
		stop = function() for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end end,
	}
end

-- ดูสัญญาณ V2 ภายใน sec วินาที: Cooldown.Size ขยับ หรือ ได้ยินเสียง Race  -> คืน true, ชื่อสัญญาณ / ไม่เจอ -> false
local function WatchRaceV2(sec, sw)
	local first
	local t0 = tick()
	while tick() - t0 < sec do
		if sw.hit() then return true, "Sound" end
		local o = RaceCooldownObj()
		if o then
			if first == nil then first = o.Size
			elseif o.Size ~= first then return true, "Cooldown" end
		end
		task.wait(0.1)
	end
	return sw.hit(), sw.hit() and "Sound" or nil
end

-- คืน 2 (V2) / 1 (ยังไม่ได้ทำ V2) / nil (กำลังเช็คอยู่หรือเพิ่งเช็ค ให้ใช้ค่าเดิม)
function ProbeRaceV2(force)
	if RaceProbe.ver == 2 then return 2 end            -- เจอ V2 แล้วจำไว้ ไม่ต้องกดซ้ำ
	if RaceProbe.busy then return RaceProbe.ver end
	if not force and RaceProbe.ver ~= nil and tick() - RaceProbe.last < 600 then return RaceProbe.ver end   -- กันกดสกิลรัวๆ (ผล V1 จำไว้ 10 นาที / force=true ข้ามได้)
	RaceProbe.busy = true
	local result, how = 1, nil
	local sw = NewRaceSoundWatcher()
	for attempt = 1, 2 do                               -- รอบ 1 เปิดเผ่า / ไม่เจอสัญญาณ -> เปิดใหม่ 1 รอบ
		FireRaceSkill()
		task.wait(0.3)
		local moved, src = WatchRaceV2(2, sw)
		if moved then result, how = 2, src break end
	end
	sw.stop()
	RaceProbe.ver, RaceProbe.last, RaceProbe.busy = result, tick(), false
	print("[RaceProbe] เช็คเผ่า ->", result == 2 and ("V2 (สัญญาณ: " .. tostring(how) .. ")") or "V1 (ไม่เจอ Cooldown ขยับ/เสียง Race)")
	return result
end

-- อ่านเผ่า: ชื่อเผ่าจาก PlayerData.Race.Value  เวอร์ชัน (V#) จากข้อความใน GUI เหมือนเดิม
-- คืนค่า: ชื่อเผ่า, เวอร์ชัน, ข้อความรวม เช่น "Human (V1)"
function ReadRace()
	local name
	pcall(function()
		name = game:GetService("Players").LocalPlayer.PlayerData.Race.Value
	end)
	local ver
	pcall(function()
		local txt = game:GetService("Players").LocalPlayer.PlayerGui.GameGui.Menu.Main.Container.Profile.Frame.Container.RaceFrame.Value.Text
		ver = tonumber(string.match(txt, "%(%s*[Vv](%d+)%s*%)"))
	end)
	if RaceProbe.ver == 2 then ver = 2 end                       -- เช็ค Cooldown เจอ V2 แล้ว -> ใช้ V2 ตามนั้น (GUI อาจบัคค้างเป็น V1)
	if ver == nil and name ~= nil then ver = ProbeRaceV2() end   -- GUI อ่านไม่ได้ -> ใช้วิธีเช็ค Cooldown แทน
	if name == nil and ver == nil then return nil end
	name = tostring(name or "?")
	return name, ver, ver and string.format("%s (V%d)", name, ver) or name
end

-- ฟาร์มเลเวลปกติเปิดได้ก็ต่อเมื่อไม่มีโหมดอื่นทำงานอยู่
function FarmAllowed()
	if not _G.XH_Auto then return false end
	return not (_G.Raid or _G.RaceV2 or _G.FlameKatana or _G.EvilNoob or _G.ItemQuest or _G.Boss or _G.Baller or _G.Aura or _G.HakiReroll)
end

-- ===== Baller fighting style: มีเงินถึง BallerMoney -> ทำก่อนโหมดอื่นทั้งหมด =====
-- ===== ตัวเช็กไอเทมกลาง (ทุกที่ที่เช็กว่า "ได้ของแล้ว" ใช้ตัวนี้) =====
-- ต้องเป็น Tool จริงๆ ใน Backpack หรือในมือ และชื่อตรงเป๊ะ (ไม่สนตัวพิมพ์ใหญ่เล็ก/ช่องว่างหัวท้าย)
-- เดิมใช้ FindFirstChild ชื่อเฉยๆ -> โฟลเดอร์/ออบเจกต์อื่นที่ชื่อซ้ำก็นับว่า "ได้ของ"
function FindTool(name)
	if not name then return nil end
	local function NormName(x)
		x = tostring(x or ""):gsub("^%s+", "")
		x = x:gsub("%s+$", "")
		return string.lower(x)
	end
	local want = NormName(name)
	local function scan(parent)
		if not parent then return nil end
		for _, ch in ipairs(parent:GetChildren()) do
			if ch:IsA("Tool") and NormName(ch.Name) == want then return ch end
		end
		return nil
	end
	return scan(LocalPlayer.Character) or scan(LocalPlayer:FindFirstChildOfClass("Backpack"))
end

function OwnsTool(name) return FindTool(name) ~= nil end

-- รอให้ตัวละคร + Backpack โหลดครบก่อนเช็กของ (กันเช็กตอน Tool ยังไม่ถูกโหลดแล้วสรุปว่า "ไม่มี")
function WaitToolsLoaded(maxSec)
	local t0 = tick()
	while tick() - t0 < (maxSec or 15) do
		local c = LocalPlayer.Character
		if c and c:FindFirstChildOfClass("Humanoid") and c:FindFirstChild("HumanoidRootPart")
			and LocalPlayer:FindFirstChildOfClass("Backpack") then
			task.wait(1.5)
			return true
		end
		task.wait(0.25)
	end
	return false
end

-- ไฟล์เซฟ = แค่คำใบ้ (อ่านค่า done จริง ไม่ใช่แค่ "มีไฟล์")
function SavedFlag(path)
	local ok, v = pcall(function()
		if not (isfile and readfile and isfile(path)) then return false end
		local d = game:GetService("HttpService"):JSONDecode(readfile(path))
		return type(d) == "table" and d.done == true
	end)
	return ok and v == true
end

function BallerHave()
	local c = LocalPlayer.Character
	return (FindTool("Baller")) ~= nil
end

-- Auto Haki: มี task ค้าง (buy/boss) และไม่ชนบอสอื่น/Baller -> โหมดอื่นหลีกทาง (task ว่าง = รอบอสอยู่ ทำอย่างอื่นได้)
function AuraWanted()
	if not _G.XH_Auto then return false end
	return CONFIG.AutoHaki and _G.AuraTask ~= nil and not _G.AuraDone and not _G.Boss and not BallerWanted()
end

-- ทำครบทุกอย่างแล้วไหม (Baller / Flame Katana / Yellow Blade / Pink Hammer / Banana / Purple Katana ตามที่เปิดใน CONFIG)
function HakiAllDone()
	if not CONFIG.HakiRerollWaitAll then return true end
	if CONFIG.AutoBallerStyle and not _G.BallerDone then return false end
	if CONFIG.AutoFlameKatana and not _G.FlameDone and not Checklist["Weapon: Flame Katana"] then return false end
	if CONFIG.AutoEvilNoob and not _G.EvilNoobDone and not Checklist["Weapon: Yellow Blade"] then return false end
	if CONFIG.AutoItemQuests then
		for _, k in ipairs(ITEM_ORDER) do
			if not _G.ItemDone[k] then return false end
		end
	end
	return true
end

-- Auto สุ่มสีฮาคิ: ต้องมี Aura Master + ทำครบ + Gem พอ (ระหว่างสุ่มอยู่ = true ตลอด กันเรดแย่ง)
function HakiRerollWanted()
	if not _G.XH_Auto then return false end
	if not CONFIG.AutoHakiReroll or _G.HakiRerollDone or _G.Boss then return false end
	if not _G.AuraDone then return false end
	if _G.HakiReroll then return true end
	if not HakiAllDone() then return false end
	local ok, g = pcall(function() return LocalPlayer.PlayerData.Gem.Value end)
	return ok and g ~= nil and g >= (_G.HakiRerollNeedGem or CONFIG.HakiRerollMinGems or 1)
end

function BallerWanted()
	if not _G.XH_Auto then return false end
	if _G.Boss then return false end
	if not CONFIG.AutoBallerStyle or _G.BallerDone then return false end
	if BallerHave() then return false end
	if _G.Baller then return true end
	local m = ReadMoney()
	return m ~= nil and m >= CONFIG.BallerMoney
end

function FlameWanted()
	if not _G.XH_Auto then return false end
	if _G.Boss then return false end
	if not CONFIG.AutoFlameKatana or _G.FlameDone then return false end
	if BallerWanted() or AuraWanted() then return false end
	local ok, lv = pcall(function() return game:GetService("Players").LocalPlayer.PlayerData.Level.Value end)
	return ok and lv >= CONFIG.FlameKatanaMinLevel
end

function RaceV2Wanted()
	if not _G.XH_Auto then return false end
	if _G.Boss then return false end
	if not CONFIG.AutoRaceV2 or _G.RaceV2Done then return false end
	if BallerWanted() or AuraWanted() then return false end
	if FlameWanted() then return false end   -- Flame Katana มาก่อน
	local ok, lv = pcall(function() return game:GetService("Players").LocalPlayer.PlayerData.Level.Value end)
	if not ok or lv < CONFIG.RaceV2MinLevel then return false end
	local _, ver = ReadRace()
	if ver ~= 1 then return false end
	-- GUI บอกว่า V1 (หรืออ่านไม่ได้) -> ยืนยันด้วยการเปิดสกิลเผ่า + ดู Cooldown.Size ก่อนไปทำเควส
	-- เผื่อ GUI บัคค้างเป็น V1 ทั้งที่เป็น V2 แล้ว
	local pv = ProbeRaceV2()
	if pv == 2 then
		_G.RaceV2Done = true
		print("[RaceV2] ยืนยันจาก Cooldown เผ่าเป็น V2 แล้ว -> ข้ามโหมด Race V2")
		return false
	end
	if pv == nil then return _G.RaceV2 == true end   -- กำลังเช็คอยู่ -> คงสถานะเดิมไว้ก่อน
	return true
end

function EvilNoobWanted()
	if not _G.XH_Auto then return false end
	if _G.Boss then return false end
	if not CONFIG.AutoEvilNoob or _G.EvilNoobDone then return false end
	if DropX2Needed and DropX2Needed() then return false end   -- ยังไม่ได้ซื้อ Drop X2 -> ยังไม่ทำ Yellow Blade (ไปเรดหา Gem ก่อน)
	if _G.NoobRaidPhase then return false end   -- พักทำดาบ ไปเรดจน Gem ถึง NoobRaidGems ก่อน
	if BallerWanted() or AuraWanted() then return false end
	local ok, lv = pcall(function() return game:GetService("Players").LocalPlayer.PlayerData.Level.Value end)
	if not ok or lv < CONFIG.EvilNoobMinLevel then return false end
	return not (FlameWanted() or RaceV2Wanted())   -- Flame Katana / Race V2 มาก่อน
end

-- ===== Item Quests (Pink Hammer / Banana / Purple Katana) =====
-- ลำดับความสำคัญ: Flame Katana > Race V2 > Evil Noob > Item Quests > Raid / Pumpkin
_G.ItemDone = _G.ItemDone or {}
ITEM_INFO = {
	PinkHammer   = { name = "Pink Hammer",   ui = "Weapon: Pink Hammer" },
	Banana       = { name = "Banana",        ui = "Weapon: Banana" },
	PurpleKatana = { name = "Purple Katana", ui = "Weapon: Purple Katana" },
}
ITEM_ORDER = { "PinkHammer", "Banana", "PurpleKatana" }

-- มีไอเทมในกระเป๋า/ในมืออยู่แล้วไหม
function ItemHave(name)
	local c = LocalPlayer.Character
	return (FindTool(name)) ~= nil
end

-- เอาออกจากคลังมาที่กระเป๋า (UpdateInventory "Weapon") แล้วรอดูว่าเข้ากระเป๋าไหม  คืน true = มีในกระเป๋า
function ItemUnstore(name, timeout)
	if ItemHave(name) then return true end
	task.spawn(function()
		pcall(function()
			game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent", 5):WaitForChild("ItemEvents", 5)
				:WaitForChild("UpdateInventory", 5):InvokeServer("Weapon", { SelectedItem = name })
		end)
	end)
	local t0 = tick()
	while not ItemHave(name) and tick() - t0 < (timeout or 3) do task.wait(0.2) end
	return ItemHave(name)
end

function ItemWanted(key)
	if _G.Boss then return false end
	if not CONFIG.AutoItemQuests or _G.ItemDone[key] then return false end
	if BallerWanted() or AuraWanted() then return false end
	local ok, lv = pcall(function() return game:GetService("Players").LocalPlayer.PlayerData.Level.Value end)
	if not ok or not lv then return false end
	if key == "PinkHammer" then
		return lv >= CONFIG.PinkHammerMinLevel
	elseif key == "Banana" then
		if lv < CONFIG.BananaMinLevel then return false end
		if _G.ItemQuest and _G.ItemQuestKey == "Banana" then return true end   -- เริ่มทำแล้ว ไม่ต้องเช็กเงินซ้ำ
		local m = ReadMoney()
		return m ~= nil and m >= CONFIG.BananaMinMoney
	elseif key == "PurpleKatana" then
		return lv >= CONFIG.PurpleKatanaMinLevel
	end
	return false
end

-- คืนชื่อ key ของไอเทมที่ควรทำตอนนี้ (nil = ไม่มี)  ทำอันที่ทำค้างอยู่ต่อก่อน
function ItemQuestWanted()
	if not _G.XH_Auto then return nil end
	if not CONFIG.AutoItemQuests then return nil end
	if FlameWanted() or RaceV2Wanted() or EvilNoobWanted() then return nil end
	if _G.NoobRaidPhase then return nil end   -- ช่วงไปเรดรอทำดาบ: ไม่แทรกเควสไอเทม
	if _G.ItemQuest and _G.ItemQuestKey and ItemWanted(_G.ItemQuestKey) then return _G.ItemQuestKey end
	for _, k in ipairs(ITEM_ORDER) do
		if ItemWanted(k) then return k end
	end
	return nil
end

-- ===== Drop Item X2: ยังไม่ซื้อ -> เรดต่อจน Gem ถึง NoobRaidGems (50000) แล้วซื้อ ค่อยกลับไปใช้ RaidStopGems =====
-- เช็กว่ามี Gamepass แล้วหรือยังด้วย MarketplaceService (เช็กในเธรดแยก ไม่หน่วงลูปอื่น)
local function CheckDropX2Owned()
	local ok, owned = pcall(function()
		return game:GetService("MarketplaceService"):UserOwnsGamePassAsync(LocalPlayer.UserId, CONFIG.DropX2GamepassId)
	end)
	if ok and owned == true then _G.DropX2Owned = true end
	return ok and owned == true
end

function DropX2Needed()
	if not CONFIG.AutoBuyDropX2 or not CONFIG.AutoRaid then return false end
	return not (_G.DropX2Bought or _G.DropX2Owned)
end

if CONFIG.AutoBuyDropX2 and CONFIG.AutoRaid then CheckDropX2Owned() end   -- เช็กรอบแรกก่อนเลือกโหมดเริ่มต้น

task.spawn(function()
	while task.wait(1) do
		if CONFIG.AutoBuyDropX2 and not _G.DropX2Owned then
			CheckDropX2Owned()
			task.wait(120)   -- ยังไม่มี -> เช็กซ้ำทุก 2 นาที (เผื่อซื้อเอง)
		else
			return
		end
	end
end)

-- บอกเหตุผลว่าทำไมตอนนี้ "ไม่เข้า/ออกจากโหมดเรด" (ไว้ดูใน console ว่าทำไมไปฟาร์มข้างนอก)
function RaidWhyNot()
	if _G.Boss then return "กำลังมีบอส: " .. tostring(_G.BossTarget) end
	if not CONFIG.AutoRaid then return "AutoRaid ปิดอยู่" end
	if FlameWanted() then return "Flame Katana มาก่อนเรด" end
	if RaceV2Wanted() then return "Race V2 มาก่อนเรด (เผ่ายังถูกอ่านว่า V1 ไปทำเควส Sogga)" end
	if EvilNoobWanted() then return "Evil Noob มาก่อนเรด" end
	if not _G.Raid and ItemQuestWanted() then return "Item Quest มาก่อนเรด: " .. tostring(ItemQuestWanted()) end
	local ok, msg = pcall(function()
		local d = LocalPlayer.PlayerData
		local stop = (_G.NoobRaidPhase or DropX2Needed()) and CONFIG.NoobRaidGems or CONFIG.RaidStopGems
		if d.Level.Value < CONFIG.RaidMinLevel then
			return string.format("เลเวล %d ยังไม่ถึง %d", d.Level.Value, CONFIG.RaidMinLevel)
		end
		if d.Gem.Value >= stop then
			return string.format("Gem %d >= เกณฑ์หยุดเรด %d (ซื้อ X2แล้ว/มีแล้ว=%s)", d.Gem.Value, stop, tostring(not DropX2Needed()))
		end
		return "เข้าเงื่อนไขเรดปกติ"
	end)
	return ok and msg or "อ่านข้อมูลผู้เล่นไม่ได้"
end

function RaidWanted()
	if not _G.XH_Auto then return false end
	if _G.Boss then return false end
	if not CONFIG.AutoRaid then return false end
	if not _G.Raid and (BallerWanted() or AuraWanted() or HakiRerollWanted()) then return false end
	if FlameWanted() or RaceV2Wanted() or EvilNoobWanted() then return false end   -- Flame Katana / Race V2 / Evil Noob มาก่อน
	if not _G.Raid and ItemQuestWanted() then return false end                      -- Item Quests มาก่อน (ไม่ตัดเรดที่กำลังทำอยู่)
	local ok, res = pcall(function()
		local d = LocalPlayer.PlayerData
		local stop = (_G.NoobRaidPhase or DropX2Needed()) and CONFIG.NoobRaidGems or CONFIG.RaidStopGems
		return d.Level.Value >= CONFIG.RaidMinLevel and d.Gem.Value < stop
	end)
	return ok and res or false
end

pcall(function()   -- รอข้อมูลผู้เล่นโหลดก่อนตัดสินใจ
	local d = LocalPlayer:WaitForChild("PlayerData", 10)
	d:WaitForChild("Level", 5)
	d:WaitForChild("Gem", 5)
end)
function PumpkinWanted()
	if not _G.XH_Auto then return false end
	if _G.Boss then return false end
	if not CONFIG.AutoPumpkin then return false end
	if BallerWanted() or AuraWanted() or HakiRerollWanted() then return false end
	if FlameWanted() or RaceV2Wanted() or EvilNoobWanted() then return false end
	if ItemQuestWanted() then return false end   -- Item Quests มาก่อน
	local ok, res = pcall(function()
		local lv = LocalPlayer.PlayerData.Level.Value
		return lv >= CONFIG.PumpkinMinLevel and lv < CONFIG.PumpkinMaxLevel
	end)
	return ok and res or false
end

-- ก่อนเริ่มทำ: เอาออกจากคลังมาเช็กก่อนทุกอัน ถ้ามีในกระเป๋าแล้ว = ทำเสร็จแล้ว (ไฟเขียวใน UI)
if CONFIG.AutoItemQuests or CONFIG.AutoEvilNoob then WaitToolsLoaded(15) end   -- รอ Backpack โหลดก่อนเช็ก
if CONFIG.AutoItemQuests then
	for _, key in ipairs(ITEM_ORDER) do
		local info = ITEM_INFO[key]
		if ItemUnstore(info.name, 4) then
			_G.ItemDone[key] = true
			SetDone(info.ui)
			print("[ItemQuest] มี " .. info.name .. " แล้ว ข้าม")
		end
	end
end

if CONFIG.AutoEvilNoob and ItemUnstore("Yellow Blade", 4) then
	_G.EvilNoobDone = true
	SetDone("Weapon: Yellow Blade")
	print("[EvilNoob] มี Yellow Blade แล้ว ข้าม")
end

if FlameWanted() then
	_G.AutoFarm = false
	_G.FlameKatana = true
	print("[FlameKatana] เริ่มในโหมด Flame Katana ตั้งแต่ต้น")
elseif RaceV2Wanted() then
	_G.AutoFarm = false
	_G.RaceV2 = true
	print("[RaceV2] เริ่มในโหมด Race V2 ตั้งแต่ต้น")
elseif EvilNoobWanted() then
	_G.AutoFarm = false
	_G.EvilNoob = true
	print("[EvilNoob] เริ่มในโหมด Evil Noob ตั้งแต่ต้น")
elseif ItemQuestWanted() then
	_G.AutoFarm = false
	_G.ItemQuest = true
	_G.ItemQuestKey = ItemQuestWanted()
	print("[ItemQuest] เริ่มในโหมด Item Quest ตั้งแต่ต้น:", _G.ItemQuestKey)
elseif RaidWanted() then
	_G.AutoFarm = false
	_G.Raid = true
	_G.GoRaid = true
	print("[Raid] เริ่มในโหมด Raid ตั้งแต่ต้น")
elseif PumpkinWanted() then
	_G.AutoFarm = false
	_G.Pumpkin = true
	print("[Pumpkin] เริ่มในโหมด Giant Pumpkin ตั้งแต่ต้น")
end

-- ===================== Quest table =====================
function CheckQuest()
        local MyLevel = game:GetService("Players").LocalPlayer.PlayerData.Level.Value
        if MyLevel >= 1 and MyLevel <= 49 then
            Mob = "Floppa"
            FrameQ = CFrame.new(564.91650390625, -37.043067932128906, -556.4757690429688)
        elseif MyLevel == 50 or MyLevel <= 99 then
           Mob = "Golden Floppa"
           FrameQ = CFrame.new(562.2315673828125, -37.043067932128906, -914.1873779296875)
       elseif MyLevel == 100 or MyLevel <= 149 then--BossMob
           Mob = "Big Floppa"
           FrameQ = CFrame.new(470.8048400878906, -3.5550005435943604, -1403.531982421875)
       elseif MyLevel == 150 or MyLevel <= 199 then
           Mob = "Doge"
           FrameQ = CFrame.new(868.4557495117188, -37.043067932128906, -735.547119140625)
       elseif MyLevel == 200 or MyLevel <= 249 then
           Mob = "Cheems"
           FrameQ = CFrame.new(902.94384765625, -37.04301071166992, -1503.9013671875)
       elseif MyLevel == 250 or MyLevel <= 299 then--BossMob
           Mob = "Walter Dog"
           FrameQ = CFrame.new(10.436995506286621, -37.043067932128906, -1034.9451904296875)
       elseif MyLevel == 300 or MyLevel <= 349 then
           Mob = "Staring Fish"
           FrameQ = CFrame.new(-2942.891845703125, -55.27851104736328, -1876.39599609375)
       elseif MyLevel == 350 or MyLevel <= 399 then
           Mob = "Hamster"
           FrameQ = CFrame.new(-3143.15576171875, -55.27851104736328, -1811.48095703125)
       elseif MyLevel == 400 or MyLevel <= 449 then--BossMob
           Mob = "Snow Tree"
           FrameQ = CFrame.new(-2924.063720703125, -77.63380432128906, -2323.243896484375)
       elseif MyLevel == 450 or MyLevel <= 499 then
           Mob = "The Rock"
           FrameQ = CFrame.new(-2995.177001953125, -55.27851104736328, -1754.591064453125)
       elseif MyLevel == 500 or MyLevel <= 549 then
           Mob = "Banana Cat"
           FrameQ = CFrame.new(-3393.187744140625, -51.4274787902832, -2150.902099609375)
       elseif MyLevel == 550 or MyLevel <= 599 then
           Mob = "Sus Face"
           FrameQ = CFrame.new(-3080.643310546875, -77.63941955566406, -2312.59423828125)
       elseif MyLevel == 600 or MyLevel <= 649 then
           Mob = "Egg Dog"
           FrameQ = CFrame.new(-3063.50830078125, -91.0500259399414, 589.280517578125)
       elseif MyLevel == 650 or MyLevel <= 699 then
           Mob = "Popcat"
           FrameQ = CFrame.new(-3390.79052734375, -91.10002136230469, 445.5372619628906)
       elseif MyLevel == 700 or MyLevel <= 749 then
           Mob = "Gorilla King"
           FrameQ = CFrame.new(-3685.647705078125, -91.49403381347656, 360.2413635253906)
       elseif MyLevel == 750 or MyLevel <= 799 then
           Mob = "Smiling Cat"
           FrameQ = CFrame.new(-749.9562377929688, -92.70011138916016, -2891.1279296875)
       elseif MyLevel == 800 or MyLevel <= 849 then
           Mob = "Killerfish"
           FrameQ = CFrame.new(-294.51788330078125, -92.70011138916016, -2777.8896484375)
       elseif MyLevel == 850 or MyLevel <= 899 then
           Mob = "Bingus"
           FrameQ = CFrame.new(-456.5486755371094, -92.70011138916016, -2856.85888671875)
       elseif MyLevel == 900 or MyLevel <= 949 then
           Mob = "Obamid"
           FrameQ = CFrame.new(-462.0100402832031, -61.09877395629883, -3530.655517578125)
       elseif MyLevel == 950 or MyLevel <= 999 then
           Mob = "Floppy"
           FrameQ = CFrame.new(-1353.90576171875, -89.65943908691406, 937.8524169921875)
       elseif MyLevel == 1000 or MyLevel <= 1049 then
           Mob = "Creepy Head"
           FrameQ = CFrame.new(-869.3150024414062, -90.90943908691406, 1081.836669921875)
       elseif MyLevel == 1050 or MyLevel <= 1149 then
           Mob = "Scary Skull"
           FrameQ = CFrame.new(-1421.9774169921875, -92.91299438476562, 1250.7928466796875)
       elseif MyLevel == 1150 or MyLevel <= 1199 then
           Mob = "Pink Absorber"
           FrameQ = CFrame.new(1831.557861328125, 121.98255920410156, 3444.105224609375)
       elseif MyLevel == 1200 or MyLevel <= 1249 then
           Mob = "Troll Face"
           FrameQ = CFrame.new(-2911.781494140625, -81.08662414550781, 2824.142822265625)
       elseif MyLevel == 1250 or MyLevel <= 1299 then
           Mob = "Uncanny Cat"
           FrameQ = CFrame.new(-2897.91552734375, -81.08662414550781, 3190.833984375)
       elseif MyLevel == 1300 or MyLevel <= 1349 then
           Mob = "Quandale Dingle"
           FrameQ = CFrame.new(-2588.55126953125, -81.08662414550781, 2989.777099609375)
       elseif MyLevel == 1350 or MyLevel <= 1449 then
           Mob = "Moai"
           FrameQ = CFrame.new(-2661.221923828125, -81.08602142333984, 3380.985107421875)
       elseif MyLevel == 1450 or MyLevel <= 1499 then
           Mob = "Red Sus"
           FrameQ = CFrame.new(1070.100341796875, -51.79351043701172, 2818.936279296875)
       elseif MyLevel == 1500 or MyLevel <= 1699 then
           Mob = "Sus Duck"
           FrameQ = CFrame.new(1562.4791259765625, -51.79351043701172, 2328.5)
       elseif MyLevel == 1700 or MyLevel <= 1749 then
           Mob = "Sigma Man"
           FrameQ = CFrame.new(7964.869140625, 30.75599479675293, 4546.0576171875)
       elseif MyLevel == 1750 or MyLevel <= 1799 then
           Mob = "Dancing Cat"
           FrameQ = CFrame.new(8331.3466796875, 30.75599479675293, 4494.4736328125 )
       elseif MyLevel == 1800 or MyLevel <= 1849 then
           Mob = "Toothless Dragon"
           FrameQ = CFrame.new(7906.49462890625, 30.75599479675293, 4783.05908203125)
       elseif MyLevel == 1850 or MyLevel <= 1899 then
           Mob = "Manly Nugget"
           FrameQ = CFrame.new(8273.84375, 30.75599479675293, 4778.83740234375)
       elseif MyLevel == 1900 or MyLevel <= 1949 then
           Mob = "Huh Cat"
           FrameQ = CFrame.new(3924.419189453125, -58.149635314941406, -1238.689453125)
       elseif MyLevel == 1950 or MyLevel <= 1999 then
           Mob = "Mystical Tree"
           FrameQ = CFrame.new(3698.140380859375, -58.149635314941406, 69.95709991455078)
       elseif MyLevel == 2000 or MyLevel <= 2049 then
           Mob = "Old Man"
           FrameQ = CFrame.new(4346.48486328125, -92.56228637695312, 233.11241149902344)
       elseif MyLevel == 2050 or MyLevel <= 2099 then
           Mob = "Nyan Cat"
           FrameQ = CFrame.new(4892.54541015625, -92.56233978271484, 232.9646453857422)
       elseif MyLevel == 2100 or MyLevel <= 2149 then
           Mob = "Baller"
           FrameQ = CFrame.new(1277.290283203125, -54.329017639160156, -4668.7890625)
       elseif MyLevel == 2150 or MyLevel <= 2199 then
           Mob = "Slicer"
           FrameQ = CFrame.new(1339.090087890625, -54.32901382446289, -4913.8251953125)
       elseif MyLevel == 2200 or MyLevel <= 2249 then
           Mob = "Rick Roller"
           FrameQ = CFrame.new(2231.442138671875, -90.56163024902344, -4788.474609375)
       elseif MyLevel == 2250 or MyLevel <= 2300 then
           Mob = "Gigachad"
           FrameQ = CFrame.new(1330.892822265625, -90.5616455078125, -5374.544921875)
       elseif MyLevel == 2300 or MyLevel <= 2349 then
           Mob = "MrBeast"
           FrameQ = CFrame.new(1876.98828125, 24.897499084472656, -5284.12890625)
       elseif MyLevel >= 2350 then
           Mob = "Handsome Man"
           FrameQ = CFrame.new(2278.8076171875, -90.5616455078125, -5399.32666015625)
        end
    end
    

-- ===================== Helpers =====================
function TP(cf)
	local hrp = LocalPlayer.Character.HumanoidRootPart
	hrp.CFrame = cf
	hrp.AssemblyLinearVelocity = Vector3.zero      -- ล้างความเร็ว: วาร์ปทุกเฟรมแล้วความเร็วไม่สะสมจนดีดตัว
	hrp.AssemblyAngularVelocity = Vector3.zero
end

-- ===== กันบัค: มอนที่กำลังตีเลือดไม่ลดติดต่อกัน StuckSeconds วินาที -> ฆ่าตัวตายรีตัวละคร =====
local StuckMob, StuckHp, StuckSince, StuckLastCall, LastStuckReset = nil, 0, 0, 0, 0
function CheckStuck(mob)
	if not CONFIG.ResetIfHitStuck or InRaidNow() then StuckMob = nil return end   -- ในเรดไม่ฆ่าตัวตายรีตัวละคร
	local hum = mob and mob:FindFirstChild("Humanoid")
	local now = tick()
	if not hum or hum.Health <= 0 then StuckMob = nil StuckLastCall = now return end
	if StuckMob ~= mob or now - StuckLastCall > 1.5 or hum.Health < StuckHp then
		-- มอนตัวใหม่ / เพิ่งกลับมาตี / เลือดลดลง -> เริ่มนับใหม่
		StuckMob, StuckHp, StuckSince = mob, hum.Health, now
	else
		if hum.Health > StuckHp then StuckHp = hum.Health end   -- มอนฟื้นเลือด ไม่รีเซ็ตเวลา
		if now - StuckSince >= CONFIG.StuckSeconds and now - LastStuckReset > 10 then
			LastStuckReset = now
			StuckMob = nil
			warn(string.format("[HitStuck] ตี %s แล้วเลือดไม่ลด %d วิ -> ฆ่าตัวตายรีตัวละคร", mob.Name, CONFIG.StuckSeconds))
			local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if h then h.Health = 0 end
		end
	end
	StuckLastCall = now
end

-- ===== Bring Mob: เปลี่ยนโหมดทีไร ล้างเป้าหมายดึงมอนทิ้ง (กันค้างชื่อมอนจากโหมดก่อน เช่น Pink Absorber) =====
task.spawn(function()
	local last
	while task.wait(0.2) do
		local sig = table.concat({
			tostring(_G.AutoFarm), tostring(_G.Raid), tostring(_G.Pumpkin), tostring(_G.RaceV2),
			tostring(_G.FlameKatana), tostring(_G.EvilNoob), tostring(_G.ItemQuest),
			tostring(_G.ItemQuestKey), tostring(_G.Boss),
		}, "|")
		if last and sig ~= last then
			StartMagnet = false
			Mon = nil
			PosMon = nil
		end
		last = sig
	end
end)

function EquipWeapon(name)
	local bp = LocalPlayer.Backpack:FindFirstChild(name)
	if bp then
		task.wait()
		LocalPlayer.Character.Humanoid:EquipTool(bp)
	end
end

-- platform ใต้เท้า + noclip ตอนฟาร์ม
RunService.RenderStepped:Connect(function()
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if (_G.AutoFarm or _G.Raid or _G.Pumpkin or _G.RaceV2 or _G.FlameKatana or _G.EvilNoob or _G.ItemQuest or _G.Boss) and hrp then
		local p = workspace:FindFirstChild("TaiFoot")
		if not p then
			p = Instance.new("Part")
			p.Name = "TaiFoot"; p.Anchored = true; p.Transparency = 1
			p.Size = Vector3.new(16, 0.5, 16); p.Parent = workspace
		end
		p.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 3.92, hrp.Position.Z)
	else
		local p = workspace:FindFirstChild("TaiFoot")
		if p then p:Destroy() end
	end
end)

RunService.Stepped:Connect(function()
	if (_G.AutoFarm or _G.Raid or _G.Pumpkin or _G.RaceV2 or _G.FlameKatana or _G.EvilNoob or _G.ItemQuest or _G.Boss) and LocalPlayer.Character then
		for _, v in ipairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
end)

-- ตั้งค่าอาวุธตาม ToolTip
task.spawn(function()
	local tip = { FightingStyle = "Fighting Style", Power = "Power", Weapon = "Weapon" }
	while task.wait(0.5) do
		pcall(function()
			local want = tip[CONFIG.Weapon]
			-- ได้หมัด Baller แล้ว -> ใช้ Baller เป็นหมัดหลักทุกเลเวล (ไม่สนว่าจะมีสไตล์อื่นอยู่ด้วย)
			if CONFIG.Weapon == "FightingStyle" and CONFIG.UseBallerWhenOwned ~= false and BallerHave() then
				_G.SelectWeapon = "Baller"
				return
			end
			for _, v in ipairs(LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") and v.ToolTip == want then
					_G.SelectWeapon = v.Name
					break
				end
			end
		end)
	end
end)

-- ท่าทางฟาร์ม
task.spawn(function()
	while task.wait() do
		local d = _G.DistanceMob
		if _G.Method == "Behind" then
			MethodFarm = CFrame.new(0, 0, d)
		elseif _G.Method == "Below" then
			MethodFarm = CFrame.new(0, -d, 0) * CFrame.Angles(math.rad(90), 0, 0)
		else
			MethodFarm = CFrame.new(0, d, 0) * CFrame.Angles(math.rad(-90), 0, 0)
		end
	end
end)

-- ===================== ตามมอนแบบนิ่ง (ไม่หมุนตามมอน + วาร์ปทุกเฟรม) =====================
-- เดิม: วาร์ปไป root.CFrame * MethodFarm ในลูป task.wait -> มอนหมุน/วิ่ง = ตัวละครหันก้มๆเงยๆ และตามไม่ทัน
-- ใหม่: ใช้ตำแหน่งมอน + ออฟเซ็ตในโลก (ไม่หมุนตามมอน) ทิศคงที่ + วาร์ปซ้ำทุก Stepped/Heartbeat + เล็งล่วงหน้าตามความเร็วมอน
local Follow = { root = nil, t = 0 }
function Follow.CF(root)
	local d = _G.DistanceMob or CONFIG.Distance
	local p = root.Position
	local vel = root.AssemblyLinearVelocity
	local lead = CONFIG.FollowLead or 0.08
	-- มอนกระเด็น/ความเร็วพุ่ง (เกิน 60) = ไม่ใช่การเดินปกติ -> ไม่เล็งล่วงหน้า (กันตัวละครพุ่งตาม)
	if lead > 0 and vel.Magnitude < 60 then p = p + vel * lead end
	local sm = CONFIG.FollowSmooth or 0
	if _G.Raid and sm > 0 then
		local now = tick()
		if Follow.sroot ~= root or not Follow.sp or (Follow.sp - p).Magnitude > 20 then
			Follow.sp = p                                   -- เปลี่ยนเป้า/มอนวาร์ปไกล -> ตามทันที
		else
			Follow.sp = Follow.sp:Lerp(p, 1 - math.exp(-math.max(now - (Follow.st or now), 0) * sm))
		end
		Follow.st, Follow.sroot = now, root
		p = Follow.sp
	end
	local m = _G.Method or CONFIG.Method
	if m == "Behind" then
		local look = root.CFrame.LookVector
		local flat = Vector3.new(look.X, 0, look.Z)
		flat = flat.Magnitude > 0.01 and flat.Unit or Vector3.new(0, 0, -1)
		local pos = p - flat * d
		return CFrame.lookAt(pos, Vector3.new(p.X, pos.Y, p.Z))
	elseif m == "Below" then
		return CFrame.new(p.X, p.Y - d, p.Z) * CFrame.Angles(math.rad(90), 0, 0)
	end
	return CFrame.new(p.X, p.Y + d, p.Z) * CFrame.Angles(math.rad(-90), 0, 0)
end
function Follow.Set(root)
	Follow.root, Follow.t = root, tick()
	TP(Follow.CF(root))
end
local function FollowStep()
	local root = Follow.root
	if not root or not root.Parent or tick() - Follow.t > 0.25 then return end
	-- ในเรด: มอนที่กำลังตีห้ามพุ่ง/กระเด็น ล็อกความเร็วให้นิ่ง
	if _G.Raid and CONFIG.RaidFreezeMob ~= false then
		pcall(function()
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end)
	end
	local ch = LocalPlayer.Character
	local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
	local hum = ch and ch:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum or hum.Health <= 0 then return end
	hrp.CFrame = Follow.CF(root)
	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero
end
KeepConn(RunService.Stepped:Connect(FollowStep))
KeepConn(RunService.Heartbeat:Connect(FollowStep))

-- ===================== Hover รอมอนเกิด =====================
local HOVER_HEIGHT = 60
local HoverOrigin = nil
local LastHoverOrigin = nil   -- จุดฐานของการลอยครั้งล่าสุด (กันลอยสูงขึ้นสะสม)

local function HoverWait(travelCF)
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	if not HoverOrigin then
		if travelCF and (hrp.Position - travelCF.Position).Magnitude > 150 then
			TP(travelCF)
			return
		end
		-- ถ้าตอนนี้ยังลอยอยู่ที่จุดเดิม (อยู่สูงกว่าฐาน 60) ให้ใช้ฐานเดิม
		-- ไม่ใช่ตำแหน่งปัจจุบัน ไม่งั้นจะบวกความสูงเพิ่มทุกครั้งที่ HoverOrigin ถูกรีเซ็ต
		if LastHoverOrigin
			and (hrp.Position - (LastHoverOrigin + Vector3.new(0, HOVER_HEIGHT, 0))).Magnitude < 25 then
			HoverOrigin = LastHoverOrigin
		else
			HoverOrigin = hrp.Position
		end
		LastHoverOrigin = HoverOrigin
	end
	hrp.CFrame = CFrame.new(HoverOrigin + Vector3.new(0, HOVER_HEIGHT, 0))
	hrp.AssemblyLinearVelocity = Vector3.zero
	hrp.AssemblyAngularVelocity = Vector3.zero
end

local function WaitForMob(mobName, travelCF)
	local folder = workspace:FindFirstChild("Monster")
	if folder then
		for _, m in ipairs(folder:GetChildren()) do
			local hum = m:FindFirstChild("Humanoid")
			if m.Name == mobName and hum and hum.Health > 0 then
				HoverOrigin = nil
				return
			end
		end
	end
	HoverWait(travelCF)
end

task.spawn(function()
	while task.wait(0.2) do
		if StartMagnet then HoverOrigin = nil end
	end
end)

-- ===================== Bring Mob =====================
local BringTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)

local function GetBaseY(mob, root)
	local y = mob:GetAttribute("BringBaseY")
	if not y then
		y = root.Position.Y
		mob:SetAttribute("BringBaseY", y)
	end
	return y
end

local function NoCollideMob(mob)
	if mob:GetAttribute("BringNoCollide") then return end
	mob:SetAttribute("BringNoCollide", true)
	for _, part in ipairs(mob:GetDescendants()) do
		if part:IsA("BasePart") then part.CanCollide = false end
	end
end

-- มอนที่ถูกดึงมาแล้ว (ตัวที่ไม่ใช่เป้าหมาย) จะหมุนรอบจุดฟาร์ม
local BringOrbit, BringCenter, BringRingN = {}, nil, 1

local function RingOffset(angle)
	return Vector3.new(math.cos(angle) * _G.BringSpread, 0, math.sin(angle) * _G.BringSpread)
end

local function TweenMob(root, dest, onDone)
	root:SetAttribute("Tweening", true)
	local tw = TweenService:Create(root, BringTweenInfo, { CFrame = CFrame.new(dest) })
	tw:Play()
	tw.Completed:Once(function()
		if root then root:SetAttribute("Tweening", false) end
		if onDone then onDone() end
	end)
end

local function BringEnemy()
	if _G.Raid then return end                 -- โหมด Raid ไม่ต้อง Bring Mob
	if not _G.BringMonster or not StartMagnet or not PosMon or not Mon then return end
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local target = PosMon.Position
	local startDist = math.max(80, (_G.DistanceMob or 8) + 20)
	if (hrp.Position - target).Magnitude > startDist then return end

	local picked = {}
	for _, mob in ipairs(workspace.Monster:GetChildren()) do
		if mob.Name == Mon then
			local hum = mob:FindFirstChild("Humanoid")
			local root = mob:FindFirstChild("HumanoidRootPart")
			if hum and root and hum.Health > 0 then
				local dist = (root.Position - target).Magnitude
				if dist <= _G.BringRange then
					table.insert(picked, { m = mob, hum = hum, root = root, d = dist })
				end
			end
		end
	end
	if #picked == 0 then return end
	table.sort(picked, function(a, b) return a.d < b.d end)

	local groundY = GetBaseY(picked[1].m, picked[1].root)
	local spot = Vector3.new(target.X, groundY, target.Z)

	-- จัดตำแหน่งมอนแต่ละตัวไม่ให้ซ้ำกัน:
	-- ตัวใกล้สุด (เป้าหมายที่กำลังตี) อยู่ตรงกลาง ตัวอื่นกระจายเป็นวงรอบๆ ตามช่อง (slot)
	-- ช่องถูกล็อกไว้ต่อมอนแต่ละตัว (ไม่สลับช่องไปมา มอนจะไม่วิ่งสลับที่กัน)
	local limit = math.min(#picked, _G.MaxBringMobs)
	local ringCount = math.max(1, _G.MaxBringMobs - 1)
	local used = {}
	for i = 2, limit do
		local m = picked[i].m
		local slot = m:GetAttribute("BringSlot")
		if slot and slot <= ringCount and not used[slot] then
			used[slot] = true
		else
			m:SetAttribute("BringSlot", nil)
		end
	end
	for i = 2, limit do
		local m = picked[i].m
		if not m:GetAttribute("BringSlot") then
			for slot = 1, ringCount do
				if not used[slot] then
					used[slot] = true
					m:SetAttribute("BringSlot", slot)
					break
				end
			end
		end
	end

	BringCenter, BringRingN = spot, ringCount
	local now = os.clock()
	local speed = _G.BringOrbitSpeed or 0

	for i = 1, limit do
		local p = picked[i]
		local root, hum = p.root, p.hum

		NoCollideMob(p.m)
		if hum.WalkSpeed ~= 0 then hum.WalkSpeed = 0; hum.JumpPower = 0 end
		if root.Size.X > 10 then root.Size = Vector3.new(2, 2, 1) end
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero

		if i == 1 then
			-- เป้าหมายที่กำลังตี: อยู่กลางจุดฟาร์ม ไม่หมุน
			if not root:GetAttribute("Tweening") then
				if (root.Position - spot).Magnitude > 1.5 then
					TweenMob(root, spot)
				elseif math.abs(root.Position.Y - groundY) > 1 then
					root.CFrame = CFrame.new(root.Position.X, groundY, root.Position.Z) * (root.CFrame - root.CFrame.Position)
				end
			end
		else
			-- ตัวอื่น: tween เข้าวง (ล่วงหน้า 0.5 วินาที ให้ถึงพอดีกับตำแหน่งที่หมุนไปถึง)
			-- พอถึงแล้ว (BringArrived) ลูป Heartbeat ด้านล่างจะพาหมุนรอบต่อ
			local slot = p.m:GetAttribute("BringSlot") or 1
			local base = (slot - 1) * (2 * math.pi / ringCount)
			BringOrbit[p.m] = { root = root, slot = slot }

			if p.m:GetAttribute("BringArrived") then
				local expected = spot + RingOffset(base + now * speed)
				if (root.Position - expected).Magnitude > 10 then
					p.m:SetAttribute("BringArrived", false)      -- หลุดวง/จุดเปลี่ยน -> ไปเข้าวงใหม่
				end
			elseif not root:GetAttribute("Tweening") then
				local dest = spot + RingOffset(base + (now + 0.5) * speed)
				local mob = p.m
				TweenMob(root, dest, function() mob:SetAttribute("BringArrived", true) end)
			end
		end
	end
end

-- ปล่อยมอนที่ถูกดึงมาจากเป้าหมายก่อนหน้า: ส่งกลับจุดเกิดของมัน (ไม่ให้ติดมาหมุนรอบจุดฟาร์มใหม่)
local function ReleaseMob(mob, root)
	pcall(function()
		mob:SetAttribute("BringArrived", false)
		local cf
		local part = workspace.Location.Enemy_Location:FindFirstChild(mob.Name)
		if part and part:IsA("BasePart") then cf = part.CFrame end
		if cf then root.CFrame = cf end
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end)
end

-- หมุนมอนที่เข้าวงแล้วรอบจุดฟาร์มทุกเฟรม (หันหน้าเข้าหาศูนย์กลาง)
RunService.Heartbeat:Connect(function()
	-- ชื่อมอนไม่ตรงกับเป้าหมายปัจจุบัน (เปลี่ยนมอน/เปลี่ยนโหมด) -> ปล่อยออกจากวง
	for mob, st in pairs(BringOrbit) do
		local root = st.root
		if not mob.Parent or not root or not root.Parent then
			BringOrbit[mob] = nil
		elseif mob.Name ~= Mon then
			ReleaseMob(mob, root)
			BringOrbit[mob] = nil
		end
	end
	if not (_G.BringMonster and StartMagnet and BringCenter) or _G.Raid then return end
	local t = os.clock()
	local speed = _G.BringOrbitSpeed or 0
	for mob, st in pairs(BringOrbit) do
		local root = st.root
		if not mob.Parent or not root or not root.Parent then
			BringOrbit[mob] = nil
		elseif mob:GetAttribute("BringArrived") then
			local ang = (st.slot - 1) * (2 * math.pi / BringRingN) + t * speed
			local pos = BringCenter + RingOffset(ang)
			root.CFrame = CFrame.lookAt(pos, BringCenter)
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end
	end
end)

task.spawn(function()
	while task.wait(0.2) do pcall(BringEnemy) end
end)

task.spawn(function()
	while task.wait(1.5) do
		if _G.BringMonster and not _G.Raid and StartMagnet and sethiddenproperty then
			pcall(sethiddenproperty, LocalPlayer, "SimulationRadius", math.huge)
		end
	end
end)

-- ===================== Auto Farm Level =====================
local VirtualUser = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")
local RS = game:GetService("ReplicatedStorage")

-- ===== เลือกอาวุธตอนตี: ดาบดีสุดที่มี + สกิล Z/X (ดูคูลดาวจาก Skill_Container.Z/X.Cooldown.Size) =====
-- Size ขยับ = กำลังคูลดาว / นิ่ง = พร้อมใช้   ถ้า Z และ X คูลดาวทั้งคู่ -> ถือดาบตีธรรมดาต่อ (ไม่สลับหมัด)
local CdTrack = { Z = { size = nil, changed = 0 }, X = { size = nil, changed = 0 } }
local SkillLastPress = { Z = 0, X = 0, C = 0, V = 0 }
local SwordEquippedAt, SwordFistUntil = 0, 0

local function BestSword()
	local c = LocalPlayer.Character
	for _, name in ipairs(CONFIG.SwordPriority) do
		if FindTool(name) then return name end
	end
end

local function SkillCooling(key)
	local ok, size = pcall(function()
		return LocalPlayer.PlayerGui.Weapon.Skill_Container[key].Cooldown.Size
	end)
	if not ok then return true end            -- อ่านไม่ได้ = ถือว่าใช้สกิลไม่ได้ -> ใช้หมัด
	local t = CdTrack[key]
	if t.size ~= size then t.size = size; t.changed = tick() end
	return tick() - t.changed < 0.3
end

-- เล็งสกิลไปที่มอนก่อนกด: หันกล้องมองมอน + ย้ายเมาส์ไปกลางจอ (ตำแหน่งมอน) ให้สกิลที่อิงเมาส์/กล้องโดนเป้า
-- _G.SkillTarget = HumanoidRootPart ของมอนที่กำลังตี (ตั้งค่าก่อนเรียก CombatEquip)
local function PressSkill(key)
	if tick() - SkillLastPress[key] < 0.3 then return end
	SkillLastPress[key] = tick()
	local t = _G.SkillTarget
	local cam = workspace.CurrentCamera
	local prevType
	if t and t.Parent and cam then
		pcall(function()
			prevType = cam.CameraType
			cam.CameraType = Enum.CameraType.Scriptable
			cam.CFrame = CFrame.lookAt(cam.CFrame.Position, t.Position)
			local vp = cam.ViewportSize
			VIM:SendMouseMoveEvent(vp.X / 2, vp.Y / 2, game)
		end)
		task.wait(0.05)   -- รอให้เมาส์/กล้องอัปเดตก่อนกด
	end
	VIM:SendKeyEvent(true, key, false, game)
	task.wait(0.05)
	VIM:SendKeyEvent(false, key, false, game)
	if prevType and cam then pcall(function() cam.CameraType = prevType end) end
end

local function AtMaxLevel()
	local ok, lv = pcall(function() return LocalPlayer.PlayerData.Level.Value end)
	return ok and lv and lv >= (CONFIG.MaxLevel or 2400)
end

-- ===== LvMax + ในเรด: วนสลับดาบหลายเล่มตามคูลดาวสกิล =====
local SwordBlockedUntil, RotEquippedAt = {}, 0

local function OwnedSwords()
	local list, c = {}, LocalPlayer.Character
	for _, name in ipairs(CONFIG.SwordPriority) do
		if FindTool(name) then
			table.insert(list, name)
		end
	end
	return list
end

-- อ่านแถบคูลดาว Z/X สองครั้งห่างกัน SwordCdSample วินาที: ขนาดขยับ/อ่านไม่ได้ = คูลดาว
local function ReadCooling()
	local function rd(key)
		local ok, sz = pcall(function() return LocalPlayer.PlayerGui.Weapon.Skill_Container[key].Cooldown.Size end)
		return ok and sz or nil
	end
	local z1, x1 = rd("Z"), rd("X")
	task.wait(CONFIG.SwordCdSample or 0.1)
	local z2, x2 = rd("Z"), rd("X")
	return (z1 == nil or z1 ~= z2), (x1 == nil or x1 ~= x2)
end

local function RotateSwords()
	local swords = OwnedSwords()
	if #swords == 0 then return false end
	local c = LocalPlayer.Character
	local held
	for _, n in ipairs(swords) do
		if c and c:FindFirstChild(n) then held = n break end
	end
	local now = tick()

	-- ยังไม่ถือดาบ -> หยิบเล่มแรกที่ไม่ถูกข้าม
	if not held then
		local pick = swords[1]
		for _, n in ipairs(swords) do
			if (SwordBlockedUntil[n] or 0) <= now then pick = n break end
		end
		EquipWeapon(pick)
		RotEquippedAt = tick()
		return true
	end

	if tick() - RotEquippedAt < (CONFIG.SwordSwapSettle or 0.12) then return true end

	local zCool, xCool = ReadCooling()
	if not zCool or not xCool then
		if not zCool then PressSkill("Z") end
		if not xCool then PressSkill("X") end
		return true
	end

	-- ดาบนี้คูลดาวทั้งคู่ -> ข้ามไว้ แล้วสลับไปเล่มถัดไปที่พร้อม (ไม่มีเล่มอื่น = ถือเล่มเดิมตีธรรมดา)
	SwordBlockedUntil[held] = tick() + (CONFIG.SwordRotateBlock or 1)
	if #swords == 1 then return true end
	local idx = 1
	for i, n in ipairs(swords) do if n == held then idx = i break end end
	local nextSword, soonest, soonestT
	for k = 1, #swords - 1 do
		local n = swords[((idx - 1 + k) % #swords) + 1]
		local b = SwordBlockedUntil[n] or 0
		if b <= tick() then nextSword = n break end
		if not soonestT or b < soonestT then soonest, soonestT = n, b end
	end
	nextSword = nextSword or soonest
	if nextSword and nextSword ~= held then
		EquipWeapon(nextSword)
		RotEquippedAt = tick()
	end
	return true
end

-- ===================== สกิลหมัด Baller (Z/X/C/V) แบบกดปุ่ม =====================
-- ถือ Baller + มอนในระยะ -> กดสกิลที่พร้อม (PressSkill: หันกล้อง/เมาส์ไปที่มอนแล้วกดปุ่ม เหมือนสกิลดาบเดิม)
BallerState = { last = {}, cd = {}, busy = false }

function HeldTool()
	local c = LocalPlayer.Character
	if not c then return end
	for _, v in ipairs(c:GetChildren()) do
		if v:IsA("Tool") then return v end
	end
end

function BallerSkillReady(key)
	local st = BallerState
	-- แถบคูลดาวของหมัด: PlayerGui.FightingStyle.Skill_Container[ปุ่ม].Cooldown
	local ok, size = pcall(function()
		return LocalPlayer.PlayerGui.FightingStyle.Skill_Container[key].Cooldown.Size
	end)
	if not ok then
		return tick() - (st.last[key] or 0) >= (CONFIG.BallerSkillGap or 2.5)   -- อ่านคูลดาวไม่ได้ -> จับเวลาเอง
	end
	local t = st.cd[key]
	if not t then t = { size = nil, changed = 0 } st.cd[key] = t end
	if t.size ~= size then t.size = size; t.changed = tick() end
	if tick() - t.changed < 0.3 then return false end                        -- Cooldown กำลังขยับ = ยังคูลดาว
	return tick() - (st.last[key] or 0) >= 0.4
end

function BallerSkillTick()
	if not CONFIG.BallerSkills then return end
	local st = BallerState
	if st.busy then return end
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local tool = HeldTool()
	local t = _G.SkillTarget
	if not (hrp and tool and tool.Name == "Baller" and t and t.Parent) then return end
	if (t.Position - hrp.Position).Magnitude > (CONFIG.BallerSkillRange or 120) then return end
	for _, key in ipairs(CONFIG.BallerKeys or {}) do
		if BallerSkillReady(key) then
			st.busy = true
			st.last[key] = tick()
			task.spawn(function()
				pcall(PressSkill, key)
				st.busy = false
			end)
			return
		end
	end
end

function CombatEquip()
	local fist = _G.SelectWeapon
	-- มี Baller แล้ว -> ใช้ Baller อย่างเดียวทุกเลเวล (รวมถึงเลเวลตัน ไม่สลับไปถือดาบ)
	local useBaller = CONFIG.UseBallerWhenOwned ~= false and BallerHave()
	local sword = CONFIG.UseSwordSkills and not useBaller and BestSword()
	if not sword then
		EquipWeapon(useBaller and "Baller" or fist)
		BallerSkillTick()              -- สกิล Baller (กดปุ่มแบบเดิม)
		return
	end

	-- เลเวลสูงสุด + อยู่ในเรด: วนสลับดาบหลายเล่มตามคูลดาวสกิล
	if CONFIG.SwordOnlyAtMax and CONFIG.SwordRotateInRaid and AtMaxLevel() and InRaidNow() then
		if RotateSwords() then return end
	end

	-- เลเวลสูงสุด: ถือดาบอย่างเดียว ไม่สลับไปหมัดแม้สกิลคูลดาว (ตีธรรมดาด้วยดาบ)
	if CONFIG.SwordOnlyAtMax and AtMaxLevel() then
		local c = LocalPlayer.Character
		if not (c and c:FindFirstChild(sword)) then
			EquipWeapon(sword)
			SwordEquippedAt = tick()
			CdTrack.Z.size, CdTrack.X.size = nil, nil
			return
		end
		if tick() - SwordEquippedAt < 0.4 then
			SkillCooling("Z"); SkillCooling("X")
			return
		end
		if not SkillCooling("Z") then PressSkill("Z") end
		if not SkillCooling("X") then PressSkill("X") end
		return
	end

	local char = LocalPlayer.Character
	if char and char:FindFirstChild(sword) then
		-- ดาบอยู่ในมือ: รอ GUI คูลดาวอัปเดตหลังสลับ แล้วค่อยเช็ก
		if tick() - SwordEquippedAt < 0.4 then
			SkillCooling("Z"); SkillCooling("X")
			return
		end
		local zCool, xCool = SkillCooling("Z"), SkillCooling("X")
		if not zCool or not xCool then
			if not zCool then PressSkill("Z") end
			if not xCool then PressSkill("X") end
		else
			SwordFistUntil = tick() + CONFIG.SwordRetrySeconds   -- คูลดาวทั้งคู่ -> สลับไปใช้หมัด
			EquipWeapon(fist)
		end
	else
		if tick() >= SwordFistUntil then
			EquipWeapon(sword)
			SwordEquippedAt = tick()
			CdTrack.Z.size, CdTrack.X.size = nil, nil
		else
			EquipWeapon(fist)
		end
	end
end

-- ดาบที่ซื้อแล้วแต่ยังอยู่ในคลัง (ไม่อยู่ในกระเป๋า) ต้องเอาออกมาก่อนถึงจะถือได้
-- ไล่ตามลำดับ SwordPriority: อันไหนอยู่ในกระเป๋าแล้ว = หยุด (ไม่ต้องหาอันที่ด้อยกว่า) / ไม่อยู่ -> ลองเอาออกจากคลัง
function EnsureBestSword()
	local c = LocalPlayer.Character
	for _, name in ipairs(CONFIG.SwordPriority) do
		if FindTool(name) then return name end
		if ItemUnstore(name, 1.5) then
			print("[Sword] เอา " .. name .. " ออกจากคลัง")
			return name
		end
	end
end

-- LvMax: เอาดาบทุกเล่มใน SwordPriority ออกจากคลังมาไว้ในกระเป๋า (ไว้ใช้สลับในเรด)
function EnsureAllSwords()
	local c = LocalPlayer.Character
	for _, name in ipairs(CONFIG.SwordPriority) do
		if not (FindTool(name)) then
			if ItemUnstore(name, 1.5) then print("[Sword] เอา " .. name .. " ออกจากคลัง") end
		end
	end
end

if CONFIG.UseSwordSkills then
	task.spawn(function()
		while true do
			if not InRaidNow() then
				if CONFIG.SwordOnlyAtMax and CONFIG.SwordRotateInRaid and AtMaxLevel() then
					pcall(EnsureAllSwords)
				else
					pcall(EnsureBestSword)
				end
			end
			task.wait(20)   -- เช็กซ้ำเป็นระยะ เผื่อเพิ่งซื้อ/ได้ดาบที่ดีกว่าเพิ่ม
		end
	end)
end

local LastAccept, AcceptTries = 0, 0
local QuestPromptCache = {}

task.spawn(function()
	while task.wait() do
		if _G.XH_Auto and _G.AutoFarm and not _G.Raid then
			while FruitBusy or ShopBusy or StoreBusy do task.wait(0.1) end
			pcall(function()
				if not _G.XH_Auto or not _G.AutoFarm or _G.Raid then return end   -- โหมดเปลี่ยนระหว่างรอ -> ไม่วาร์ปไปฟาร์ม
				CheckQuest()
				local gui = LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1
				if not string.find(gui.Target.Text, Mob) then
					RS.OtherEvent.QuestEvents.Quest:FireServer("Abandon_Quest", { QuestSlot = "QuestSlot1" })
				end

				if gui.Visible == false then
					local hrp = LocalPlayer.Character.HumanoidRootPart
					if (FrameQ.Position - hrp.Position).Magnitude > 3 then
						TP(FrameQ)                                   -- ไปที่ NPC ครั้งเดียว ไม่วาร์ปซ้ำทุกเฟรม
						task.wait(0.25)
					elseif tick() - LastAccept > 0.6 then            -- กด E ทุก 0.6 วินาที (ไม่ใช่ทุกเฟรม)
						LastAccept = tick()
						AcceptTries = AcceptTries + 1
						VIM:SendKeyEvent(true, "E", false, game)
						task.wait(0.05)
						VIM:SendKeyEvent(false, "E", false, game)
						-- กด E หลายครั้งแล้วยังไม่รับ -> ยิง ProximityPrompt ที่ "ใกล้ที่สุด" ตัวเดียว (สแกนครั้งเดียวต่อจุด)
						if AcceptTries >= 4 and fireproximityprompt then
							local key = tostring(FrameQ.Position)
							if QuestPromptCache.key ~= key then
								QuestPromptCache.key = key
								QuestPromptCache.prompt = nil
								local best
								for _, d in ipairs(workspace:GetDescendants()) do
									if d:IsA("ProximityPrompt") and d.Parent and d.Parent:IsA("BasePart") then
										local dist = (d.Parent.Position - FrameQ.Position).Magnitude
										if dist <= 12 and (not best or dist < best) then
											best = dist
											QuestPromptCache.prompt = d
										end
									end
								end
							end
							if QuestPromptCache.prompt then pcall(fireproximityprompt, QuestPromptCache.prompt) end
						end
					else
						task.wait(0.05)
					end
					return
				else
					AcceptTries = 0                                  -- รับเควสแล้ว -> รีเซ็ตตัวนับ
					if workspace.Monster:FindFirstChild(Mob) then
						for _, v in ipairs(workspace.Monster:GetChildren()) do
							if v.Name == Mob and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
								repeat
									task.wait()
									while FruitBusy or ShopBusy or StoreBusy do task.wait(0.1) end -- หยุดฟาร์มชั่วคราวตอนไปเก็บผลไม้
									if not _G.AutoFarm or _G.Raid then break end
									_G.SkillTarget = v.HumanoidRootPart
									CombatEquip()
									Follow.Set(v.HumanoidRootPart)
									CheckStuck(v)
									StartMagnet = true
									PosMon = v.HumanoidRootPart.CFrame
									Mon = Mob
									VirtualUser:CaptureController()
									VirtualUser:Button1Down(Vector2.new(1280, 672), workspace.Camera.CFrame)
								until not _G.AutoFarm or _G.Raid or not v.Parent or v.Humanoid.Health <= 0 or gui.Visible == false
								StartMagnet = false
							end
						end
					end
					local tpl = RS.EnemyTemplate:FindFirstChild(Mob)
					if tpl and _G.AutoFarm and not _G.Raid then
						WaitForMob(Mob, tpl.HumanoidRootPart.CFrame * CFrame.new(5, 10, 2))
					end
				end
			end)
		end
	end
end)

-- กำลังอยู่ในเรด (RaidGui ขึ้น) หรือกำลังรอ Start ที่จุดเข้าเรด -> ห้ามมีอะไรมาขัด (เก็บผลไม้/เก็บเข้าคลัง/ซื้อของ/ถอดดาบ/ซื้อ X2/รีตัว)
function InRaidNow()
	if _G.RaidJoining then return true end
	local ok, v = pcall(function() return LocalPlayer.PlayerGui.RaidGui.RaidFrame.Visible end)
	return ok and v == true
end

-- ผลไม้ที่เก็บเข้าคลังไม่ได้ (คลังของผลนั้นเต็ม) -> จำชื่อไว้ ข้ามการเก็บ/เก็บจากพื้น ไม่ให้ค้างลูปหรือเสียเวลาวาร์ป
local FullFruits = {}
local function IsFruitFull(name)
	local t = FullFruits[name]
	if not t then return false end
	if tick() - t > (CONFIG.FruitFullRetrySeconds or 600) then FullFruits[name] = nil return false end
	return true
end

-- ===================== Bring Fruit (เก็บผลไม้ที่ดรอป) =====================
task.spawn(function()
	while task.wait(0.3) do
		if CONFIG.BringFruit and not ShopBusy and not StoreBusy and not InRaidNow() then
			pcall(function()
				local drops = workspace:FindFirstChild("Dropped_Items")
				if not drops then return end
				for _, v in ipairs(drops:GetChildren()) do
					local tried = v:GetAttribute("FruitTried") or 0
					if tried < 2 and string.find(v.Name, "Power") and not IsFruitFull(v.Name) and v:FindFirstChild("Handle") then
						v:SetAttribute("FruitTried", tried + 1)
						FruitBusy = true
						local t0 = tick()
						while v.Parent and tick() - t0 < 1.5 and not InRaidNow() do
							TP(v.Handle.CFrame)
							task.wait()
						end
					end
				end
			end)
			FruitBusy = false
		end
	end
end)

-- ===================== Auto Store Fruit =====================
-- ลำดับ: หยุดฟาร์ม/Raid ไม่ให้ถือหมัด (StoreBusy) -> ถือผลไม้ -> เก็บเข้าคลัง -> ปล่อยให้ฟาร์มกลับมาถือหมัดเอง
local function FruitTools()
	local list = {}
	for _, container in ipairs({ LocalPlayer.Backpack, LocalPlayer.Character }) do
		if container then
			for _, v in ipairs(container:GetChildren()) do
				if v:IsA("Tool") and string.find(v.Name, "Power") and not IsFruitFull(v.Name) then
					table.insert(list, v)
				end
			end
		end
	end
	return list
end

local function StoreTool(tool)
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	-- ถือผลไม้ แล้วรอจนผลไม้อยู่ในมือจริง
	hum:EquipTool(tool)
	for _ = 1, 15 do
		if tool.Parent == char then break end
		task.wait(0.1)
	end
	if tool.Parent ~= char then return end

	-- ลองเก็บ 2 รอบ: ถ้าผลยังอยู่หลังเก็บทั้งสองรอบ = คลังของผลนี้เต็ม -> จำไว้ว่าเก็บไม่ได้
	for attempt = 1, 2 do
		if tool.Parent ~= char and tool.Parent ~= LocalPlayer.Backpack then return true end
		if tool.Parent ~= char then hum:EquipTool(tool) task.wait(0.2) end
		RS.OtherEvent.MainEvents.Modules:FireServer("Eatable_Power", {
			Action = "Store",
			Tool = workspace.Character[Delta][tool.Name],
		})
		-- รอให้ผลไม้หายจากมือ/กระเป๋า = เก็บสำเร็จ (สูงสุด ~2 วินาที)
		for _ = 1, 20 do
			if tool.Parent ~= char and tool.Parent ~= LocalPlayer.Backpack then return true end
			task.wait(0.1)
		end
	end
	if tool.Parent == char or tool.Parent == LocalPlayer.Backpack then
		FullFruits[tool.Name] = tick()
		pcall(function() hum:UnequipTools() end)   -- วางผลที่เก็บไม่ได้ลง ไม่ถือค้างมือ
		warn(string.format("[Store] เก็บ %s เข้าคลังไม่ได้ -> คลังผลนี้เต็ม ข้ามไป %d วินาที", tool.Name, CONFIG.FruitFullRetrySeconds or 600))
		return false
	end
	return true
end

task.spawn(function()
	while task.wait(0.5) do
		if CONFIG.AutoStore and not ShopBusy and not InRaidNow() then
			pcall(function()
				local fruits = FruitTools()
				if #fruits == 0 then return end
				StoreBusy = true
				task.wait(0.4)                       -- ให้ลูปฟาร์มหยุดแย่งถือหมัดก่อน
				for _, tool in ipairs(fruits) do
					if InRaidNow() then break end
					if tool.Parent then StoreTool(tool) end
				end
			end)
			StoreBusy = false
		end
	end
end)

-- ===================== Auto Buy (ซื้ออัตโนมัติตามเงิน) =====================
-- เรียงตามลำดับความสำคัญ: เกณฑ์เงินสูงสุดก่อน
-- แต่ละรายการซื้อ 1 ครั้งต่อการรันสคริปต์ (ลองใหม่ได้สูงสุด 3 ครั้งถ้าเงินไม่ลด)
-- เซฟรายการที่ซื้อแล้วลงเครื่อง (ไฟล์ในโฟลเดอร์ workspace ของ executor แยกตามบัญชี)
-- อยากซื้อใหม่ ให้ลบไฟล์นี้ หรือลบชื่อรายการออกจากไฟล์
local HttpService = game:GetService("HttpService")
local SAVE_FILE = "MemeSea_Purchased_" .. LocalPlayer.UserId .. ".json"
local CAN_SAVE = (writefile and readfile and isfile) and true or false
if not CAN_SAVE then
	warn("[Save] executor นี้ไม่รองรับ writefile/readfile -> จำได้แค่ในรอบนี้")
end

function LoadPurchased()
	local data = {}
	if CAN_SAVE then
		pcall(function()
			if isfile(SAVE_FILE) then
				data = HttpService:JSONDecode(readfile(SAVE_FILE))
			end
		end)
	end
	if type(data) ~= "table" then data = {} end
	for name in pairs(data) do
		print("[Save] เคยซื้อแล้ว:", name)
		SetDone(name)
	end
	return data
end

function SavePurchased(done)
	if not CAN_SAVE then return end
	pcall(function()
		writefile(SAVE_FILE, HttpService:JSONEncode(done))
	end)
end

-- หลังซื้อสำเร็จ: เอา Quest Scroll ออกจากคลัง -> ถือขึ้นมือ -> ใช้
local function UseQuestScroll()
	local OE = RS:WaitForChild("OtherEvent")
	-- 1) Unstore
	OE:WaitForChild("ItemEvents"):WaitForChild("UpdateInventory"):InvokeServer("Item", {
		Action = "Unstore",
		SelectedItem = "Quest Scroll",
	})
	-- 2) รอให้ไอเท็มเข้ามาใน Backpack แล้วถือขึ้นมือ
	local tool
	for _ = 1, 25 do                          -- รอสูงสุด ~5 วินาที
		tool = LocalPlayer.Character:FindFirstChild("Quest Scroll")
		if tool then break end
		if LocalPlayer.Backpack:FindFirstChild("Quest Scroll") then
			EquipWeapon("Quest Scroll")
		end
		task.wait(0.2)
	end
	if not tool then
		warn("[QuestScroll] ไม่พบ Quest Scroll หลัง Unstore")
		return false
	end
	-- 3) ใช้
	OE:WaitForChild("MainEvents"):WaitForChild("Modules"):FireServer("Quest_Scroll", {
		Action = "Use",
		Tool = tool,
	})
	print("[QuestScroll] ใช้แล้ว")
	return true
end

-- ===== ตรวจว่าซื้อ/ใช้ Popcat (Upgrade Quest) แล้วหรือยัง จากช่องเควส =====
-- QuestGui.Holder.QuestText = "Quest Tasks [x/y]"  y = จำนวนช่องเควสสูงสุด
--   y >= 2 -> ซื้อและใช้แล้ว (เช่น [2/2] หรือ [1/2])
--   y == 1 -> ยังไม่ได้ใช้: เอา Quest Scroll ออกมาใช้ แล้วเช็กใหม่
--             ถ้าใช้แล้ว y ยังไม่เป็น 2 -> แปลว่ายังไม่ได้ซื้อ
local function ReadQuestCap()
	local ok, txt = pcall(function() return LocalPlayer.PlayerGui.QuestGui.Holder.QuestText.Text end)
	if not ok or not txt then return nil end
	local a, b = string.match(txt, "%[(%d+)%s*/%s*(%d+)%]")
	if a and b then return tonumber(a), tonumber(b) end
end

-- ไปรับเควส (ตามเลเวลปัจจุบัน) เพื่อให้ QuestText แสดงผล
local function AcceptAnyQuest()
	pcall(CheckQuest)                          -- ตั้ง FrameQ / Mob ตามเลเวล
	if not FrameQ then return false end
	local function hasQuest()
		local ok, vis = pcall(function() return LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1.Visible end)
		return ok and vis
	end
	for _ = 1, 8 do
		if hasQuest() then return true end
		TP(FrameQ)
		task.wait(0.3)
		VIM:SendKeyEvent(true, "E", false, game)
		task.wait(0.05)
		VIM:SendKeyEvent(false, "E", false, game)
		task.wait(0.6)
	end
	return hasQuest()
end

-- คืน true = ซื้อและใช้ Popcat แล้ว
local function VerifyPopcat()
	local _, cap = ReadQuestCap()
	if not cap then                            -- ยังไม่มีข้อมูล -> ไปรับเควสก่อน
		AcceptAnyQuest()
		task.wait(0.5)
		_, cap = ReadQuestCap()
	end
	if not cap then
		print("[Popcat] อ่านช่องเควสไม่ได้ -> ยังยืนยันไม่ได้")
		return false
	end
	if cap >= 2 then return true end
	-- cap == 1: ลองเอา Quest Scroll ออกมาใช้ (ถ้าซื้อไว้แต่ยังไม่ได้ใช้)
	pcall(UseQuestScroll)
	task.wait(1)
	_, cap = ReadQuestCap()
	return cap ~= nil and cap >= 2             -- ใช้แล้วยังไม่เป็น 2 = ยังไม่ได้ซื้อ
end

-- strict = true : มีตัวตรวจที่เชื่อถือได้ ตรวจไม่ผ่าน = ยังไม่ได้ซื้อ (ห้ามเดา)
-- verify ของอาวุธ (Hanger/Doge) = ดูว่ามี Tool ชื่อนั้นในกระเป๋า/คลังจริง ถ้าชื่อ Tool ไม่ตรงกับชื่อที่ส่งซื้อ จะหาไม่เจอ
--   (จึงไม่ strict) -> ถ้าเงินพอ + ซื้อ 2 รอบแล้วเงินไม่ลดทั้งสองรอบ ถึงจะถือว่า "น่าจะมีแล้ว" และเป็นแค่ชั่วคราวในรอบนี้ (ไม่เซฟลงไฟล์)
local SHOP_LIST = {
	{ name = "Upgrade Quest: Popcat", money = 1000000, pos = CFrame.new(417.228058, -3.556563, -1155.797607), args = { "Upgrade_Quest", "Popcat" }, afterBuy = UseQuestScroll, verify = VerifyPopcat, strict = true },
	{ name = "Ability: Giga Chad",    money = 100000,  pos = CFrame.new(-3062.522217, -77.401924, -2064.764648), args = { "Ability_Teacher", "Giga Chad" } },
	{ name = "Weapon: Hanger",        money = 25000,   pos = CFrame.new(209.121613, 4.287529, -1269.571167),  args = { "Weapon_Seller", "Hanger" }, verify = function() return ItemUnstore("Hanger", 3) end },
	{ name = "Weapon: Doge",          money = 5000,    pos = CFrame.new(383.401611, -36.914028, -853.046814), args = { "Weapon_Seller", "Doge" },   verify = function() return ItemUnstore("Doge", 3) end },
}

local function GetMoney()
	return ReadMoney() or 0      -- อ่านจาก PlayerGui.MainGui.CurrencyFrame_Mobile.Money.Text
end

-- คืน true = ซื้อสำเร็จ (เงินลดจริง อ่านค่าได้ทั้งก่อน/หลัง + ยืนยันซ้ำ)
-- คืน false, n = ไม่เห็นเงินลด  n = จำนวนรอบที่ "เช็กสะอาด" (เงินพอ + อ่านเงินได้ + ยืนที่จุดขาย แต่เงินไม่ลด)
-- เดิม GetMoney() คืน 0 เมื่ออ่าน GUI ไม่ได้ -> นับเป็น "เงินลด" แล้วเซฟว่าซื้อแล้วมั่วๆ
local function BuyItem(item)
	local remote = RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
	local cleanTries = 0
	for attempt = 1, 2 do
		local before = ReadMoney()
		if not before then task.wait(0.5) before = ReadMoney() end
		if before then
			TP(item.pos)
			task.wait(0.6)                      -- รอให้เซิร์ฟเวอร์รับตำแหน่ง
			remote:FireServer(unpack(item.args))
			local sawRead = false
			for _ = 1, 10 do                    -- รอดูว่าเงินลดไหม (สูงสุด ~2 วินาที เผื่อ GUI อัปเดตช้า)
				task.wait(0.2)
				local now = ReadMoney()         -- nil = อ่านไม่ได้ ไม่นับว่าเงินลด
				if now then
					sawRead = true
					if now < before then
						task.wait(0.6)          -- ยืนยันซ้ำ กัน GUI กระตุกชั่วคราว
						local again = ReadMoney()
						if again and again < before then return true end
					end
				end
			end
			if sawRead and before >= item.money then cleanTries = cleanTries + 1 end
		end
	end
	return false, cleanTries
end

task.spawn(function()
	local done = LoadPurchased()              -- ซื้อสำเร็จแล้ว (เซฟลงไฟล์)
	local tried = {}                          -- ลองแล้วในรอบนี้ (ไม่เซฟลงไฟล์)
	pcall(WaitToolsLoaded, 15)                -- รอ Backpack โหลดก่อนตรวจของ
	print("[Shop] เงินที่สคริปต์อ่านได้ (CurrencyFrame_Mobile.Money):", GetMoney())

	-- ตรวจสถานะรายการที่มีตัวตรวจ (Popcat) ตั้งแต่เริ่ม โดยไม่ต้องรอเงินถึง
	if CONFIG.AutoBuy then
		for _, item in ipairs(SHOP_LIST) do
			if item.verify and not done[item.name] then
				while FruitBusy or StoreBusy do task.wait(0.1) end
				CurrentShopItem = item.name .. " (check)"
				ShopBusy = true
				local ok, owned = pcall(item.verify)
				ShopBusy = false
				if ok and owned then
					done[item.name] = true
					SetDone(item.name)
					SavePurchased(done)
					print("[Shop] ตรวจพบว่าซื้อและใช้แล้ว:", item.name)
				end
			end
		end
	end

	while task.wait(1) do
		if CONFIG.AutoBuy and not InRaidNow() then
			for _, item in ipairs(SHOP_LIST) do
				if not done[item.name] and not tried[item.name] and GetMoney() >= item.money then
					CurrentShopItem = item.name
					ShopBusy = true
					pcall(function()
						-- รอให้การเก็บผลไม้ที่กำลังทำอยู่เสร็จก่อน
						while FruitBusy or StoreBusy do task.wait(0.1) end
						local bought, cleanTries = BuyItem(item)
						-- เงินลดจริง = ซื้อสำเร็จ / เงินไม่ลด = ต้องมีหลักฐานว่ามีของจริง (ตัวตรวจ) ไม่เดาแล้ว
						local owned, inferred = bought, false
						if not bought then
							if item.verify then
								local ok, r = pcall(item.verify)
								owned = ok and r == true
							end
							if not owned and not item.strict and (cleanTries or 0) >= 2 then
								owned, inferred = true, true   -- เงินพอ + อ่านเงินได้ + ซื้อ 2 รอบเงินไม่ลดเลย = น่าจะมีอยู่แล้ว (ชั่วคราว)
							end
						end
						if owned then
							SetDone(item.name)
							if inferred then
								-- ไม่มีหลักฐานตรงๆ: ไฟเขียวเฉพาะรอบนี้ ไม่เซฟลงไฟล์ (รอบหน้าตรวจใหม่)
								print("[Shop] ยืนยันตรงๆ ไม่ได้ (เงินไม่ลด 2 รอบทั้งที่เงินพอ) -> ถือว่ามีแล้วเฉพาะรอบนี้ ไม่เซฟ:", item.name)
							else
								done[item.name] = true
								SavePurchased(done)           -- เซฟเฉพาะที่ยืนยันแล้ว
								if bought then
									if item.afterBuy then item.afterBuy() end
								else
									print("[Shop] ตรวจพบว่ามีของจริง:", item.name)
								end
							end
						else
							print("[Shop] ยังไม่ได้ซื้อ/ยืนยันไม่ได้ (ตรวจแล้ว):", item.name)
						end
					end)
					tried[item.name] = true           -- กันวนซ้ำในรอบนี้ (ถ้าซื้อไม่สำเร็จจะไม่ถูกเซฟลงไฟล์)
					ShopBusy = false
				end
			end
		end
	end
end)

-- ===================== Auto Stats =====================
-- 1) อ่านแต้มสกิลจาก GUI  2) ถ้ายังมีแต้ม และ Melee < 2400 -> อัพ Melee ทีละ 1
-- 3) ถ้า Melee ตัน (>= 2400) -> อัพ Defense และ Sword สลับกันทีละ 1
local MELEE_CAP = 2400

local function ReadNumber(textObj)
	local ok, txt = pcall(function() return textObj.Text end)
	if not ok or not txt then return nil end
	local n = string.match((string.gsub(txt, "[,%s]", "")), "%d+")
	return n and tonumber(n) or nil
end

local function StatsGui()
	local frame = LocalPlayer.PlayerGui.GameGui.Menu.Main.Container.Stats.Frame
	return frame.SkillPoints.Point, frame.List.Melee.StatValue
end

local function UpgradeStat(target)
	local remote = RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("StatsFunction")
	remote:InvokeServer({ Target = target, Action = "UpgradeStats", Amount = 1 })
end

task.spawn(function()
	local nextIsDefense = true
	while task.wait(0.2) do
		if CONFIG.AutoStats then
			pcall(function()
				local pointObj, meleeObj = StatsGui()
				local points = ReadNumber(pointObj)
				if not points or points <= 0 then return end   -- ไม่มีแต้ม

				local melee = ReadNumber(meleeObj)
				if melee and melee < MELEE_CAP then
					UpgradeStat("MeleeLevel")
				elseif melee and melee >= MELEE_CAP then       -- Melee ตันแล้ว
					UpgradeStat(nextIsDefense and "DefenseLevel" or "SwordLevel")
					nextIsDefense = not nextIsDefense
				end
			end)
		end
	end
end)

-- ===================== Auto Reset เมื่อหมัด/อาวุธฟาร์มหาย (เกมบัค) =====================
-- ถ้าไม่พบ Tool ที่ ToolTip ตรงกับ CONFIG.Weapon ทั้งใน Backpack และในมือ ติดต่อกัน 3 วินาที
-- ขณะที่ Auto Farm ทำงาน -> ทำให้ตัวละครตาย (รีสปอว์น) เพื่อให้เกมโหลดหมัดกลับมา
local TOOLTIP_OF = { FightingStyle = "Fighting Style", Power = "Power", Weapon = "Weapon" }
local spawnTime = tick()
local lastReset = 0
LocalPlayer.CharacterAdded:Connect(function() spawnTime = tick() end)

local function HasFarmTool()
	local want = TOOLTIP_OF[CONFIG.Weapon]
	for _, container in ipairs({ LocalPlayer.Backpack, LocalPlayer.Character }) do
		if container then
			for _, t in ipairs(container:GetChildren()) do
				if t:IsA("Tool") and t.ToolTip == want then return true end
			end
		end
	end
	return false
end

task.spawn(function()
	local missing = 0
	while task.wait(1) do
		if CONFIG.ResetIfStyleLost and (_G.AutoFarm or _G.Raid or _G.Pumpkin or _G.RaceV2 or _G.FlameKatana or _G.EvilNoob or _G.ItemQuest or _G.Boss) and not ShopBusy then
			pcall(function()
				local char = LocalPlayer.Character
				local hum = char and char:FindFirstChildOfClass("Humanoid")
				-- ตายอยู่ / เพิ่งเกิดใหม่ (รอให้ของโหลด) / เพิ่งรีไป -> ยังไม่เช็ก
				if not hum or hum.Health <= 0
					or tick() - spawnTime < 8
					or tick() - lastReset < 15 then
					missing = 0
					return
				end
				if HasFarmTool() then
					missing = 0
				else
					missing = missing + 1
					if missing >= 3 then
						warn("[AutoReset] หมัด/อาวุธฟาร์มหาย -> รีตัวละคร")
						hum.Health = 0
						lastReset = tick()
						missing = 0
					end
				end
			end)
		end
	end
end)

-- ===================== Auto Raid =====================
-- เลเวล >= RaidMinLevel และ Gem < RaidStopGems -> เข้าโหมด Raid (ปิด Auto Farm Level ชั่วคราว)
-- Gem >= RaidStopGems -> ออกจากโหมด Raid แล้วกลับไปฟาร์มเลเวลตามปกติ
local RAID_JOIN_POS = CFrame.new(2749.188232421875, -57.323822021484375, -4525.55419921875)
local RaidMode = (_G.Raid == true)
local LastRaidWhy = nil

local function RaidGuiVisible()
	local ok, v = pcall(function() return LocalPlayer.PlayerGui.RaidGui.RaidFrame.Visible end)
	return ok and v or false
end

-- ตัวคุมโหมด
-- เข้าโหมดทันทีเมื่อเข้าเงื่อนไข / ออกเมื่อไม่เข้าเงื่อนไขติดกัน 3 วินาที และ "ไม่ออกกลางเรด"
task.spawn(function()
	local offCount = 0
	while task.wait(1) do
		if CONFIG.AutoRaid then
			pcall(function()
				if RaidWanted() then
					offCount = 0
					LastRaidWhy = nil
					if not RaidMode then
						RaidMode = true
						print("[Raid] เข้าโหมด Raid")
						_G.AutoFarm = false
						_G.Raid = true
						_G.GoRaid = true
						StartMagnet = false
					end
				else
					offCount = offCount + 1
					local why = RaidWhyNot()
					if why ~= LastRaidWhy then
						LastRaidWhy = why
						print("[Raid] ตอนนี้ไม่เรด เพราะ:", why)
					end
					if RaidMode and offCount >= 3 and not RaidGuiVisible() then
						RaidMode = false
						print("[Raid] ออกจากโหมด Raid -> กลับไปฟาร์มเลเวล")
						_G.Raid = false
						_G.GoRaid = false
						StartMagnet = false
						HoverOrigin = nil
						_G.DistanceMob = CONFIG.Distance
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
					end
				end
			end)
		end
	end
end)

-- ซื้อ Drop Item X2 เมื่อ Gem ถึง NoobRaidGems (ไม่ต้องรอช่วงพักทำดาบ) ถ้ายังไม่มี -> หลังซื้อจะกลับไปใช้ RaidStopGems
task.spawn(function()
	local tries = 0
	while task.wait(2) do
		pcall(function()
			if InRaidNow() then return end   -- ซื้อหลังเรดจบ
			if not DropX2Needed() then return end
			local gem = LocalPlayer.PlayerData.Gem.Value
			if gem < CONFIG.NoobRaidGems then return end
			if tries >= 3 then _G.DropX2Bought = true warn("[Raid] ซื้อ Drop X2 ไม่สำเร็จ 3 ครั้ง ยกเลิก -> ใช้ RaidStopGems") return end
			tries = tries + 1
			print("[Raid] Gem ถึง", CONFIG.NoobRaidGems, "-> ซื้อ Drop Item X2 (ครั้งที่", tries, ")")
			pcall(function()
				RS:WaitForChild("OtherEvent"):WaitForChild("BuyEvents"):WaitForChild("BuyProduct")
					:FireServer({ Action = "Buy_Gamepass", GamepassId = CONFIG.DropX2GamepassId })
			end)
			task.wait(3)
			if CheckDropX2Owned() then print("[Raid] ซื้อ Drop X2 สำเร็จ") end
		end)
	end
end)

-- ซื้อ Gem x2 เมื่อ Gem ถึง GemX2Gems (ครั้งเดียว)
task.spawn(function()
	if not CONFIG.AutoBuyGemX2 then return end
	local MPS = game:GetService("MarketplaceService")
	local tries = 0
	while task.wait(2) do
		local done = false
		pcall(function()
			if MPS:UserOwnsGamePassAsync(LocalPlayer.UserId, CONFIG.GemX2GamepassId) then done = true return end
			if InRaidNow() then return end
			if LocalPlayer.PlayerData.Gem.Value < CONFIG.GemX2Gems then return end
			if tries >= 3 then done = true warn("[GemX2] ซื้อไม่สำเร็จ 3 ครั้ง ยกเลิก") return end
			tries = tries + 1
			print("[GemX2] Gem ถึง", CONFIG.GemX2Gems, "-> ซื้อ Gem x2 (ครั้งที่", tries, ")")
			RS:WaitForChild("OtherEvent"):WaitForChild("BuyEvents"):WaitForChild("BuyProduct")
				:FireServer({ Action = "Buy_Gamepass", GamepassId = CONFIG.GemX2GamepassId })
			task.wait(3)
		end)
		if done then return end
	end
end)

-- Auto Join Raid: ยังไม่มีเรด -> ไปรอที่จุดเข้าเรด แล้วส่ง Start หลัง Join เสร็จ
-- "Join เสร็จ" = ยืนอยู่ที่จุดเข้าเรดต่อเนื่อง >= 2 วินาที และเรดยังไม่เริ่ม -> ยิง StartRaid ("Start")
-- ซ้ำทุก 5 วินาทีจนกว่าเรดจะเริ่ม (RaidFrame ขึ้น)
task.spawn(function()
	local atSince, lastStart = nil, 0
	while task.wait(0.2) do
		if _G.GoRaid then
			while FruitBusy or ShopBusy or StoreBusy do task.wait(0.1) end
			if not RaidGuiVisible() then
				pcall(TP, RAID_JOIN_POS)

				local near = false
				pcall(function()
					local hrp = LocalPlayer.Character.HumanoidRootPart
					near = (hrp.Position - RAID_JOIN_POS.Position).Magnitude <= 25
				end)
				_G.RaidJoining = near   -- ยืนที่จุดเข้าเรดรอ Start -> ล็อกไม่ให้อะไรดึงตัวไป
				if near then
					atSince = atSince or tick()
					if CONFIG.AutoStartRaid and tick() - atSince >= (CONFIG.RaidStartDelay or 3) and tick() - lastStart >= (CONFIG.RaidStartRetry or 1) then
						lastStart = tick()
						pcall(function()
							game:GetService("ReplicatedStorage"):WaitForChild("OtherEvent", 5)
								:WaitForChild("MiscEvents", 5):WaitForChild("StartRaid", 5)
								:FireServer("Start")
						end)
						print("[Raid] ส่ง Start")
					end
				else
					atSince = nil
				end
			else
				atSince = nil
				_G.RaidJoining = false
			end
		else
			atSince = nil
			_G.RaidJoining = false
		end
	end
end)

-- ===================== โหมดเอาตัวรอดใน Raid =====================
-- 1) เลือกเป้าหมายอย่างฉลาด: ใกล้ก่อน + มอนที่เลือดเหลือน้อยก่อน (ฆ่าเร็ว = โดนตีน้อยลง)
-- 2) ถ้ามอนรุมเยอะ (>= 5 ตัวในระยะ 40) -> ยืนห่างขึ้นเล็กน้อย
-- 3) เลือดต่ำกว่า RaidRetreatHp -> ถอยขึ้นที่สูง (พ้นระยะมอน) รอฟื้นถึง RaidResumeHp แล้วกลับไปสู้
--    (รอสูงสุด 20 วินาที กันค้าง แล้วพัก 10 วินาทีก่อนถอยได้อีก)
local function MyHum()
	local c = LocalPlayer.Character
	return c and c:FindFirstChildOfClass("Humanoid")
end

local function HpRatio()
	local h = MyHum()
	if h and h.MaxHealth > 0 then return h.Health / h.MaxHealth end
	return 1
end

local function IsDead()
	local h = MyHum()
	return (not h) or h.Health <= 0
end

local NoRetreatUntil = 0
local function RetreatUntilHealed()
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	StartMagnet = false
	local center = hrp.Position + Vector3.new(0, 120, 0)   -- ศูนย์กลางวงโคจร กำหนดครั้งเดียว (ไม่บวกสะสม)
	local radius, speed = CONFIG.RaidOrbitRadius, CONFIG.RaidOrbitSpeed
	local angle = 0
	local t0 = tick()
	print("[RaidSurvive] เลือดต่ำ -> ถอยขึ้นที่สูงและวิ่งวนหลบสกิล")
	while (_G.Raid or _G.Pumpkin or _G.RaceV2 or _G.FlameKatana or _G.EvilNoob or _G.ItemQuest or _G.Boss) and tick() - t0 < 20 do
		local dt = RunService.Heartbeat:Wait()
		local h = MyHum()
		local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not h or not root or h.Health <= 0 then break end
		if h.Health / h.MaxHealth >= CONFIG.RaidResumeHp then break end
		angle = angle + speed * dt
		-- วนเป็นวงกลมในแนวราบ รัศมี radius รอบจุดศูนย์กลางที่สูง 120
		local pos = center + Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
		root.CFrame = CFrame.new(pos)
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end
	NoRetreatUntil = tick() + 10
end

-- จำมอนทุกตัวที่มีอยู่ "ก่อนเรดเริ่ม" (ตอน RaidGui ยังไม่ขึ้น) -> ตอนเรดเริ่มมอนพวกนี้คือมอนข้างนอก ไม่ใช่มอนเรด
local RaidKnownMobs = setmetatable({}, { __mode = "k" })
task.spawn(function()
	while task.wait(0.2) do
		pcall(function()
			if RaidGuiVisible() then return end
			local folder = workspace:FindFirstChild("Monster")
			if not folder then return end
			for _, m in ipairs(folder:GetChildren()) do RaidKnownMobs[m] = true end
		end)
	end
end)

local function PickRaidTarget()
	local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not myRoot then return end
	local best, bestHum, bestRoot, bestScore
	local near = 0
	local onlyNew = CONFIG.RaidOnlyNewMobs ~= false
	for _, m in ipairs(workspace.Monster:GetChildren()) do
		local hum, root = m:FindFirstChild("Humanoid"), m:FindFirstChild("HumanoidRootPart")
		if hum and root and hum.Health > 0 and not (onlyNew and RaidKnownMobs[m]) then
			local d = (myRoot.Position - root.Position).Magnitude
			if d <= (CONFIG.RaidTargetRange or 1000) then   -- เลือกเฉพาะมอนในระยะ RaidTargetRange
				if d <= 40 then near = near + 1 end
				local hpRatio = hum.MaxHealth > 0 and hum.Health / hum.MaxHealth or 1
				local score = d + hpRatio * 8           -- ต่ำ = ดี (ใกล้ก่อน ไม่ข้ามไปมอนไกลเพราะเลือดเหลือน้อย -> กันพุ่งข้ามแมป)
				if not bestScore or score < bestScore then
					best, bestHum, bestRoot, bestScore = m, hum, root, score
				end
			end
		end
	end
	return best, bestHum, bestRoot, near
end

local LastRaidTargetPrint
local RaidGuiSince = nil
local RaidNav = { arena = nil, fixed = false, last = 0, warned = false }   -- arena = Vector3 ตำแหน่งเรด (จำตอน Join เรดครั้งแรก หรืออ่านจาก CONFIG.RaidArenaPos) (รวมเป็นตารางเดียว กันตัวแปร local เกินลิมิต)
if type(CONFIG.RaidArenaPos) == "table" and #CONFIG.RaidArenaPos >= 3 then
	RaidNav.arena = Vector3.new(CONFIG.RaidArenaPos[1], CONFIG.RaidArenaPos[2], CONFIG.RaidArenaPos[3])
	RaidNav.fixed = true
end

-- หาจุดเรดจาก workspace.Raids: เอาออบเจกต์ที่ชื่อมีคำว่า "Raid" (ชั้นแรกก่อน ไม่เจอค่อยหาลึกลงไป) เลือกอันที่ใกล้ตัวที่สุด
local function RaidObjPos(o)
	if o:IsA("BasePart") then return o.Position end
	if o:IsA("Model") then
		local ok, cf = pcall(function() return o:GetPivot() end)
		if ok and cf then return cf.Position end
	end
end
function RaidNav.FindInFolder()
	local folder = workspace:FindFirstChild("Raids")
	if not folder then return end
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local function pick(list)
		local best, bestD
		for _, o in ipairs(list) do
			if string.find(string.lower(o.Name), "raid", 1, true) then
				local pos = RaidObjPos(o)
				if pos then
					local d = hrp and (hrp.Position - pos).Magnitude or 0
					if not bestD or d < bestD then best, bestD = pos, d end
				end
			end
		end
		return best
	end
	return pick(folder:GetChildren()) or pick(folder:GetDescendants())
end

-- เรดเริ่มแล้ว: จำ/ตรวจตำแหน่งเรด ถ้าตัวละครอยู่ไกลจากจุดเรดเกิน RaidReturnDistance -> เทเลพอตกลับ
function RaidNav.Ensure(sinceJoin)
	if CONFIG.RaidReturn == false then return end
	local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp or IsDead() then return end
	-- ลำดับแรก: หาจาก workspace.Raids (ชื่อมีคำว่า Raid) -> วาร์ปไปเลย
	if not RaidNav.fixed then
		local fp = RaidNav.FindInFolder()
		if fp then
			local target = fp + Vector3.new(0, CONFIG.RaidFolderHeight or 5, 0)
			if (hrp.Position - target).Magnitude > (CONFIG.RaidReturnDistance or 500) and tick() - RaidNav.last >= 1 then
				RaidNav.last = tick()
				print(string.format("[Raid] พบจุดเรดใน workspace.Raids (%.0f, %.0f, %.0f) -> วาร์ปไป", fp.X, fp.Y, fp.Z))
				StartMagnet = false
				HoverOrigin = nil
				TP(CFrame.new(target))
			end
			return
		end
	end
	if not RaidNav.arena then
		-- ยังไม่รู้จุดเรด: ตัวละครถูกเกมย้ายออกจากจุดเข้าเรดแล้ว = ตำแหน่งนี้คือจุดเรด
		local fromJoin = (hrp.Position - RAID_JOIN_POS.Position).Magnitude
		if fromJoin > 150 and sinceJoin >= 0.5 then
			RaidNav.arena = hrp.Position
			print(string.format("[Raid] จำตำแหน่งเรด (%.0f, %.0f, %.0f)  -> ใส่ใน CONFIG.RaidArenaPos = {%.0f, %.0f, %.0f} ได้", RaidNav.arena.X, RaidNav.arena.Y, RaidNav.arena.Z, RaidNav.arena.X, RaidNav.arena.Y, RaidNav.arena.Z))
		elseif sinceJoin >= 6 and not RaidNav.warned then
			RaidNav.warned = true
			warn("[Raid] ยังไม่รู้ตำแหน่งเรด (ตัวละครยังอยู่ที่จุดเข้าเรด) -> ใส่พิกัดที่ CONFIG.RaidArenaPos เพื่อให้เทเลพอตไปเรดได้")
		end
		return
	end
	if (hrp.Position - RaidNav.arena).Magnitude > (CONFIG.RaidReturnDistance or 500) and tick() - RaidNav.last >= 1 then
		RaidNav.last = tick()
		print("[Raid] ไม่ได้อยู่ตำแหน่งเรด -> เทเลพอตกลับไปที่เรด")
		StartMagnet = false
		HoverOrigin = nil
		TP(CFrame.new(RaidNav.arena))
	end
end
local RaidNoMobSince, RaidFoundMob = nil, false
-- Auto Raid: เรดเริ่มแล้ว -> ตีมอนแบบเอาตัวรอด / ไม่มีมอนก็ลอยรอเวฟถัดไป
task.spawn(function()
	while task.wait() do
		if _G.Raid then
			pcall(function()
				while FruitBusy or ShopBusy or StoreBusy do task.wait(0.1) end
				if not RaidGuiVisible() then
					_G.DistanceMob = CONFIG.Distance
					RaidGuiSince = nil
					if not RaidNav.fixed then RaidNav.arena = nil end
					RaidNav.warned = false
					RaidNoMobSince, RaidFoundMob = nil, false
					return
				end
				if IsDead() then RaidNoMobSince = nil return end

				-- เพิ่ง Join เรด -> รอ RaidFarmDelay วินาทีก่อน (ลอยรอ ไม่ตี) ให้เรด/มอนโหลดครบก่อน
				if not RaidGuiSince then
					RaidGuiSince = tick()
					RaidNoMobSince, RaidFoundMob = nil, false
					StartMagnet = false
					print("[Raid] เข้าเรดแล้ว รอ", CONFIG.RaidFarmDelay or 11, "วินาทีก่อนเริ่มฟาร์ม")
				end
				RaidNav.Ensure(tick() - RaidGuiSince)   -- Join แล้วแต่ไม่ได้อยู่ตำแหน่งเรด -> เทเลพอตไปเรด
				if tick() - RaidGuiSince < (CONFIG.RaidFarmDelay or 11) then
					HoverWait()
					return
				end

				local mob, hum, root, near = PickRaidTarget()
				if not mob then
					-- รอครบแล้วยังไม่เจอมอนเรดเลย (ยังไม่เคยตีสักตัว) -> เรดบัค ฆ่าตัวตายรีตัวละคร
					local limit = CONFIG.RaidNoMobResetSeconds or 0
					if limit > 0 and not RaidFoundMob then
						RaidNoMobSince = RaidNoMobSince or tick()
						if tick() - RaidNoMobSince >= limit then
							RaidNoMobSince = nil
							warn("[Raid] ไม่เจอมอนเรด " .. limit .. " วิหลังรอครบ -> เรดบัค ฆ่าตัวตายรีตัวละคร")
							local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
							if h then h.Health = 0 end
							return
						end
					end
					-- เพิ่งตีตัวก่อนหน้าจบ: ยืนรอที่เดิมสักพัก (มอนตัวใหม่มักเกิดต่อทันที) ไม่ลอยขึ้นๆลงๆ
					if RaidFoundMob and tick() - (RaidNav.lastKill or 0) < (CONFIG.RaidGapHold or 1.5) then
						StartMagnet = false
						return
					end
					HoverWait()                          -- ไม่มีมอน: ลอยรอเวฟถัดไป
					return
				end
				RaidFoundMob, RaidNoMobSince = true, nil
				HoverOrigin = nil
				if mob ~= LastRaidTargetPrint then
					LastRaidTargetPrint = mob
					print(string.format("[Raid] เป้าหมายเรด: %s (%.0f, %.0f, %.0f)", mob.Name, root.Position.X, root.Position.Y, root.Position.Z))
				end

				-- มอนรุมเยอะ -> ยืนห่างขึ้นเล็กน้อย
				if CONFIG.RaidSmart and near >= 5 and (CONFIG.RaidCrowdDistance or 0) > 0 then
					_G.DistanceMob = math.max(CONFIG.Distance, CONFIG.RaidCrowdDistance)
				else
					_G.DistanceMob = CONFIG.Distance
				end

				repeat
					task.wait()
					while FruitBusy or ShopBusy or StoreBusy do task.wait(0.1) end
					if IsDead() then break end

					if CONFIG.RaidSmart and tick() > NoRetreatUntil and HpRatio() < CONFIG.RaidRetreatHp then
						RetreatUntilHealed()
						if IsDead() then break end
					end

					StartMagnet = true
					_G.SkillTarget = root
					CombatEquip()
					Follow.Set(root)
					PosMon = root.CFrame
					Mon = mob.Name
					VirtualUser:CaptureController()
					VirtualUser:Button1Down(Vector2.new(1280, 672), workspace.Camera.CFrame)
				until not _G.Raid or not mob.Parent or hum.Health <= 0 or not RaidGuiVisible()
				RaidNav.lastKill = tick()
				StartMagnet = false
			end)
		end
	end
end)

-- ===================== Giant Pumpkin Event (เลเวล PumpkinMinLevel..PumpkinMaxLevel-1) =====================
-- วนลูป: ไม่มี Giant Pumpkin -> ไปจุดเสก กด E รัวๆ
--        มี Giant Pumpkin เกิด -> ไปรับเควส แล้วฟาร์มมัน
--        เสกครบเวลาแล้วไม่เกิด -> ไปจุด Scary Skull ฆ่า PumpkinSkullKills ตัว แล้วกลับไปเสก
-- ถึงเลเวล PumpkinMaxLevel -> กลับไปฟาร์มเลเวลปกติ
local PUMPKIN_SUMMON_POS = CFrame.new(-1180.260742, -87.373695, 1463.069946)
local PUMPKIN_QUEST_POS  = CFrame.new(-1162.951660, -92.914436, 1462.343750)
local SKULL_POS          = CFrame.new(-1489.832764, -92.846230, 1277.917725)

local function PumpkinActive()
	return _G.XH_Auto and _G.Pumpkin and not _G.Raid
end

local function WaitBusy()
	while FruitBusy or ShopBusy or StoreBusy do task.wait(0.1) end
end

local function FindAlive(name)
	local folder = workspace:FindFirstChild("Monster")
	if not folder then return end
	for _, m in ipairs(folder:GetChildren()) do
		if m.Name == name then
			local hum, root = m:FindFirstChild("Humanoid"), m:FindFirstChild("HumanoidRootPart")
			if hum and root and hum.Health > 0 then return m, hum, root end
		end
	end
end

local function PressE()
	VIM:SendKeyEvent(true, "E", false, game)
	task.wait(0.03)
	VIM:SendKeyEvent(false, "E", false, game)
end

-- ProximityPrompt ใกล้จุดที่กำหนด (เก็บครั้งเดียวต่อรอบ กันสแกน workspace ซ้ำๆ)
local function CollectPrompts(cf, range)
	local list = {}
	if not fireproximityprompt then return list end
	for _, d in ipairs(workspace:GetDescendants()) do
		if d:IsA("ProximityPrompt") then
			local part = d.Parent
			if part and part:IsA("BasePart") and (part.Position - cf.Position).Magnitude <= range then
				table.insert(list, d)
			end
		end
	end
	return list
end

-- ---------- เช็กสปอว์นมอน (อิงวิธี Enemy_Location ที่ใช้ทดสอบแล้ว) ----------
-- workspace.Location.Enemy_Location = พาร์ตจุดเกิด ชื่อพาร์ต = ชื่อมอน
local function SpawnLocation(name)
	local ok, part = pcall(function()
		return workspace.Location.Enemy_Location:FindFirstChild(name)
	end)
	if ok and part and part:IsA("BasePart") then return part.CFrame end
end

-- สถานะสปอว์นของมอนชื่อ name: จำนวนที่ยังมีชีวิต + ระยะใกล้สุดจากจุดเกิด
local function SpawnInfo(name)
	local loc = SpawnLocation(name)
	local count, nearest = 0, math.huge
	local folder = workspace:FindFirstChild("Monster")
	if folder then
		for _, m in ipairs(folder:GetChildren()) do
			if m.Name == name then
				local hum, root = m:FindFirstChild("Humanoid"), m:FindFirstChild("HumanoidRootPart")
				if hum and hum.Health > 0 then
					count = count + 1
					if root and loc then
						local d = (root.Position - loc.Position).Magnitude
						if d < nearest then nearest = d end
					end
				end
			end
		end
	end
	return count, nearest
end

-- รายงานทุกจุดเกิด (เหมือนสคริปต์ทดสอบ) พิมพ์ในคอนโซล + คัดลอกลงคลิปบอร์ด
local function PrintSpawnReport()
	local ok, folder = pcall(function() return workspace.Location.Enemy_Location end)
	if not ok or not folder then warn("ไม่พบ Enemy_Location") return end
	local lines = {}
	for _, location in ipairs(folder:GetChildren()) do
		if location:IsA("BasePart") then
			local count, nearest = SpawnInfo(location.Name)
			local status = count > 0
				and string.format("เกิดแล้ว | จำนวน: %d | ใกล้สุด: %.2f", count, nearest)
				or "ยังไม่เกิด"
			local line = location.Name .. " | " .. status
			table.insert(lines, line)
			print(line)
		end
		task.wait()
	end
	if setclipboard then pcall(setclipboard, table.concat(lines, "\n")) end
	print("ตรวจสอบทั้งหมด:", #lines)
end

local function AttackStep(root)
	CheckStuck(root.Parent)
	_G.SkillTarget = root
	CombatEquip()
	Follow.Set(root)
	VirtualUser:CaptureController()
	VirtualUser:Button1Down(Vector2.new(1280, 672), workspace.Camera.CFrame)
end

local function MaybeRetreat()
	if tick() > NoRetreatUntil and HpRatio() < CONFIG.RaidRetreatHp then
		RetreatUntilHealed()
	end
end

-- เสก: คืน true ถ้า Giant Pumpkin เกิดแล้ว
local function SummonPumpkin()
	_G.PumpkinStatus = "Summoning Giant Pumpkin"
	StartMagnet = false
	TP(PUMPKIN_SUMMON_POS)
	task.wait(0.4)
	local prompts = CollectPrompts(PUMPKIN_SUMMON_POS, 25)
	for _ = 1, CONFIG.SummonPresses do         -- กด E แค่ SummonPresses รอบ
		if not PumpkinActive() then return false end
		WaitBusy()
		if IsDead() then return false end
		if FindAlive("Giant Pumpkin") then return true end
		pcall(TP, PUMPKIN_SUMMON_POS)
		PressE()
		for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
		task.wait(0.25)
	end
	local t1 = tick()                          -- เช็กทันที (รอเกิดไม่เกิน 2 วิ)
	while PumpkinActive() and tick() - t1 < 2 do
		if FindAlive("Giant Pumpkin") then return true end
		task.wait(0.2)
	end
	return FindAlive("Giant Pumpkin") ~= nil
end

-- รับเควส (ถ้ายังไม่มีเควส Pumpkin) แล้วฟาร์ม Giant Pumpkin
local function FightPumpkin()
	local mob, hum, root = FindAlive("Giant Pumpkin")
	if not mob then return end

	_G.PumpkinStatus = "Pumpkin Quest"
	StartMagnet = false
	local prompts = CollectPrompts(PUMPKIN_QUEST_POS, 25)
	local tries = 0
	while PumpkinActive() and tries < 8 do
		WaitBusy()
		if IsDead() then return end
		local needQuest = true
		pcall(function()
			local slot = LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1
			if slot.Visible then
				if string.find(string.lower(slot.Target.Text), "pumpkin") then
					needQuest = false
				else   -- เควสอื่นค้างอยู่ -> ยกเลิกก่อน
					RS.OtherEvent.QuestEvents.Quest:FireServer("Abandon_Quest", { QuestSlot = "QuestSlot1" })
				end
			end
		end)
		if not needQuest then break end
		tries = tries + 1
		TP(PUMPKIN_QUEST_POS)
		task.wait(0.3)
		PressE()
		for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
		task.wait(0.5)
	end

	_G.PumpkinStatus = "Fighting Giant Pumpkin"
	repeat
		task.wait()
		WaitBusy()
		if IsDead() then break end
		if CONFIG.RaidSmart then MaybeRetreat() end
		AttackStep(root)
	until not PumpkinActive() or not mob.Parent or hum.Health <= 0
end

-- ฟาร์ม Scary Skull ให้ครบ PumpkinSkullKills ตัว (หรือหยุดถ้า Giant Pumpkin เกิดขึ้นมา)
local function FarmSkulls()
	_G.PumpkinStatus = "Farming Scary Skull"
	TP(SKULL_POS)
	local kills, idle = 0, 0
	while PumpkinActive() and kills < CONFIG.PumpkinSkullKills do
		WaitBusy()
		if IsDead() then break end
		if FindAlive("Giant Pumpkin") then break end          -- เกิดแล้ว -> ไปสู้
		_G.PumpkinStatus = string.format("Farming Scary Skull (%d/%d)", kills, CONFIG.PumpkinSkullKills)
		local mob, hum, root = FindAlive("Scary Skull")
		if mob then
			idle = 0
			repeat
				task.wait()
				WaitBusy()
				if IsDead() then break end
				if CONFIG.RaidSmart then MaybeRetreat() end
				StartMagnet = true
				PosMon = root.CFrame
				Mon = "Scary Skull"
				AttackStep(root)
			until not PumpkinActive() or not mob.Parent or hum.Health <= 0
			StartMagnet = false
			if hum.Health <= 0 then
				kills = kills + 1
				print("[Pumpkin] Scary Skull", kills, "/", CONFIG.PumpkinSkullKills)
			end
		else
			-- รอมอนเกิด: ช่วงแรกรอที่จุดฟาร์ม ถ้าไม่เจอนานให้ไปยืนที่จุดเกิดจริง (Enemy_Location) กระตุ้นการเกิด
			local waitCF = (idle > 20 and SpawnLocation("Scary Skull")) or SKULL_POS
			pcall(TP, waitCF)
			task.wait(0.3)
			idle = idle + 1
			if idle > 60 then break end                       -- ~18 วินาทีไม่เจอมอน -> กลับไปเสกใหม่
		end
	end
	StartMagnet = false
end

-- ลูปหลัก
task.spawn(function()
	while task.wait(0.3) do
		if PumpkinActive() then
			pcall(function()
				WaitBusy()
				if IsDead() then return end
				if FindAlive("Giant Pumpkin") then
					FightPumpkin()
				elseif not SummonPumpkin() then
					if PumpkinActive() and not IsDead() then FarmSkulls() end   -- เสกไม่ออก -> ฟาร์มสกัลแล้ววนกลับไปเสก
				end
			end)
		else
			_G.PumpkinStatus = nil
		end
	end
end)

-- ตัวคุมโหมด Pumpkin: เข้าเมื่อเลเวลอยู่ในช่วง / ออกเมื่อพ้นช่วงติดกัน 2 วินาที (กลับไปฟาร์มเลเวลปกติ)
task.spawn(function()
	local offCount = 0
	while task.wait(1) do
		if CONFIG.AutoPumpkin then
			pcall(function()
				if PumpkinWanted() and not _G.Raid then
					offCount = 0
					if not _G.Pumpkin then
						_G.Pumpkin = true
						_G.AutoFarm = false
						StartMagnet = false
						print("[Pumpkin] เข้าโหมด Giant Pumpkin")
					end
				else
					offCount = offCount + 1
					if _G.Pumpkin and offCount >= 2 then
						_G.Pumpkin = false
						StartMagnet = false
						HoverOrigin = nil
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
						print("[Pumpkin] ออกจากโหมด Giant Pumpkin")
					end
				end
			end)
		end
	end
end)

if CONFIG.DebugSpawn then
	task.spawn(function() pcall(PrintSpawnReport) end)
end

-- ===================== Auto Race V2 =====================
-- เลเวล RaceV2MinLevel+ และเผ่ายังเป็น (V1):
--   วาร์ปไปรับเควส -> ฟาร์ม Sogga จนจบเควส -> เอา Awakening Orb ออกจากคลัง -> ถือ -> ใช้
-- ได้ Orb แล้วเช็กเผ่าซ้ำ ถ้าเป็น V2 -> เสร็จ กลับไปโหมดปกติ
do
	local RACE_QUEST_POS = CFrame.new(-2621.948486, -77.402916, -2003.441772)
	local RACE_MOB = "Sogga"

	local function QuestSlot()
		local ok, slot = pcall(function() return LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1 end)
		return ok and slot or nil
	end

	local function HasSoggaQuest()
		local slot = QuestSlot()
		return slot and slot.Visible and string.find(string.lower(slot.Target.Text), string.lower(RACE_MOB)) ~= nil
	end

	local function RaceActive() return _G.XH_Auto and _G.RaceV2 and not _G.Raid end

	-- ไปรับเควส: เควสนี้รับได้แค่ 1 ใน 2 ภารกิจ ถ้าได้ภารกิจที่ไม่ใช่ Sogga -> ยกเลิกแล้วคุยใหม่
	local function TakeQuest()
		_G.RaceV2Status = "Race V2: Quest"
		StartMagnet = false
		local prompts = CollectPrompts(RACE_QUEST_POS, 25)
		for _ = 1, 10 do
			if not RaceActive() then return false end
			WaitBusy()
			if IsDead() then return false end
			local slot = QuestSlot()
			if slot and slot.Visible then
				if HasSoggaQuest() then return true end
				RS.OtherEvent.QuestEvents.Quest:FireServer("Abandon_Quest", { QuestSlot = "QuestSlot1" })
				task.wait(0.5)
			end
			TP(RACE_QUEST_POS)
			task.wait(0.3)
			PressE()
			for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
			task.wait(0.6)
		end
		return HasSoggaQuest()
	end

	-- ฟาร์ม Sogga จนเควสหาย (Visible = false) หรือออกจากโหมด
	local function FarmSogga()
		local idle = 0
		while RaceActive() and HasSoggaQuest() do
			WaitBusy()
			if IsDead() then task.wait(1) return end
			_G.RaceV2Status = "Race V2: Farming Sogga"
			local mob, hum, root = FindAlive(RACE_MOB)
			if mob then
				idle = 0
				repeat
					task.wait()
					WaitBusy()
					if IsDead() then break end
					StartMagnet = true
					PosMon = root.CFrame
					Mon = RACE_MOB
					AttackStep(root)
				until not RaceActive() or not mob.Parent or hum.Health <= 0 or not HasSoggaQuest()
				StartMagnet = false
			else
				-- รอมอนเกิด: ไปยืนที่จุดเกิดจริง (Enemy_Location) ถ้ามี
				pcall(TP, SpawnLocation(RACE_MOB) or RACE_QUEST_POS)
				task.wait(0.3)
				idle = idle + 1
			end
		end
		StartMagnet = false
	end

	local function FindOrb()
		local c = LocalPlayer.Character
		return FindTool("Awakening Orb")
	end

	-- เอา Orb ออกจากคลัง -> ถือ -> ใช้
	local function UseOrb()
		_G.RaceV2Status = "Race V2: Using Awakening Orb"
		if not FindOrb() then
			pcall(function()
				RS:WaitForChild("OtherEvent"):WaitForChild("ItemEvents"):WaitForChild("UpdateInventory")
					:InvokeServer("Item", { Action = "Unstore", SelectedItem = "Awakening Orb" })
			end)
			local t0 = tick()
			while not FindOrb() and tick() - t0 < 5 do task.wait(0.2) end
		end
		local orb = FindOrb()
		if not orb then return false end
		if orb.Parent ~= LocalPlayer.Character then
			pcall(function() LocalPlayer.Character.Humanoid:EquipTool(orb) end)
			task.wait(0.4)
		end
		local ok = pcall(function()
			local tool = LocalPlayer.Character:WaitForChild("Awakening Orb", 5)
			RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
				:FireServer("Awakening_Orb", { Action = "Use", Tool = tool })
		end)
		return ok
	end

	local function OrbInHand()
		local c = LocalPlayer.Character
		return c and c:FindFirstChild("Awakening Orb") ~= nil
	end

	-- เก็บ Orb กลับเข้าคลัง (ถือขึ้นมือก่อน แล้วยิง Store) ลองสูงสุด 3 ครั้ง
	local function StoreOrb()
		_G.RaceV2Status = "Race V2: Storing Awakening Orb"
		for _ = 1, 3 do
			local orb = FindOrb()
			if not orb then return true end
			if orb.Parent ~= LocalPlayer.Character then
				pcall(function() LocalPlayer.Character.Humanoid:EquipTool(orb) end)
				task.wait(0.4)
			end
			pcall(function()
				local tool = LocalPlayer.Character:WaitForChild("Awakening Orb", 5)
				RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
					:FireServer("Awakening_Orb", { Action = "Store", Tool = tool })
			end)
			local t0 = tick()
			while FindOrb() and tick() - t0 < 3 do task.wait(0.2) end
			if not FindOrb() then return true end
		end
		return false
	end

	-- ===== รายชื่อเผ่าที่อัพ V2 ไม่ได้ (จำไว้ในไฟล์ ไม่ต้องลอง Orb ซ้ำ) =====
	local NA_FILE = "MemeSea_RaceV2NA_" .. LocalPlayer.UserId .. ".txt"
	local NA = {}
	pcall(function()
		if isfile and readfile and isfile(NA_FILE) then
			for n in string.gmatch(readfile(NA_FILE), "[^,\n]+") do NA[n] = true end
		end
	end)
	local function MarkNA(name)
		NA[name] = true
		if writefile then
			local list = {}
			for n in pairs(NA) do table.insert(list, n) end
			pcall(writefile, NA_FILE, table.concat(list, ","))
		end
	end

	-- ===== รีเผ่า (Watermelon Man) =====
	local WM_NAME = "Watermelon Man"
	local WATERMELON_POS = nil   -- ถ้าหา NPC อัตโนมัติไม่เจอ ใส่พิกัดเองที่นี่ เช่น CFrame.new(x, y, z)
	local wmWarned = false

	local function InstCF(inst)
		if inst:IsA("Model") then return inst:GetPivot() end
		if inst:IsA("BasePart") then return inst.CFrame end
		local part = inst:FindFirstChildWhichIsA("BasePart", true)
		return part and part.CFrame
	end

	local function FindWatermelon()
		if WATERMELON_POS then return WATERMELON_POS end
		for _, d in ipairs(workspace:GetDescendants()) do
			if d.Name == WM_NAME then
				local cf = InstCF(d)
				if cf then return cf end
			end
		end
	end

	local rerolls, noChange = 0, 0
	local function Reroll()
		if rerolls >= CONFIG.RaceRerollMax then
			_G.RaceV2Done = true
			warn("[RaceV2] รีเผ่าครบ " .. CONFIG.RaceRerollMax .. " ครั้งแล้วยังไม่ได้เผ่าที่อัพได้ หยุดโหมดนี้")
			return
		end
		rerolls = rerolls + 1
		_G.RaceV2Status = string.format("Race V2: Reroll Race (%d/%d)", rerolls, CONFIG.RaceRerollMax)
		StartMagnet = false
		local before = ReadRace()
		local cf = FindWatermelon()
		if cf then
			TP(CFrame.new(cf.Position + Vector3.new(0, 3, 0)))
		elseif not wmWarned then
			wmWarned = true
			warn("[RaceV2] ไม่พบ NPC " .. WM_NAME .. " ใน workspace -> ยิงรีเผ่าจากตำแหน่งปัจจุบัน (ถ้าไม่เวิร์กให้ใส่พิกัดที่ WATERMELON_POS)")
		end
		task.wait(0.6)
		pcall(function()
			RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
				:FireServer("Reroll_Race", WM_NAME)
		end)
		local t0, after = tick(), nil
		repeat
			task.wait(0.3)
			after = ReadRace()
		until (after and after ~= before) or tick() - t0 > 4
		if after and after ~= before then
			noChange = 0
			print("[RaceV2] รีเผ่า:", before, "->", after)
			task.wait(1.5)   -- รอ GUI อัปเดตเวอร์ชัน (V#)
		else
			noChange = noChange + 1
			if noChange >= 3 then
				_G.RaceV2Done = true
				warn("[RaceV2] รีเผ่า 3 ครั้งติดแล้วเผ่าไม่เปลี่ยน (อาจไม่พอเงิน/อยู่ไกล NPC) หยุดโหมดนี้")
			end
		end
	end

	-- ใช้ Orb: คืน "v2" | "na" (Orb ไม่หาย เผ่านี้อัพไม่ได้ เก็บกลับแล้ว) | "none" (ไม่มี Orb) | "unknown"
	local function TryOrb()
		if not UseOrb() then return "none" end
		local t0 = tick()
		while tick() - t0 < 4 and OrbInHand() do task.wait(0.2) end
		if OrbInHand() then
			StoreOrb()
			return "na"
		end
		-- Orb หายไป = ใช้สำเร็จ รอ GUI อัปเดตแล้วเช็กเผ่า
		for i = 1, 10 do
			task.wait(0.5)
			local _, ver = ReadRace()
			if ver and ver >= 2 then return "v2" end
			if i == 4 or i == 8 then   -- GUI ยังไม่อัปเดต -> เช็คด้วย Cooldown อีกทาง
				if ProbeRaceV2(true) == 2 then return "v2" end
			end
		end
		return "unknown"
	end

	task.spawn(function()
		local orbOwned, probed = false, false
		while task.wait(0.3) do
			if RaceActive() then
				pcall(function()
					WaitBusy()
					if IsDead() then return end
					local rn = ReadRace()
					if not rn then task.wait(1) return end

					-- เผ่านี้รู้อยู่แล้วว่าอัพไม่ได้ -> รีเผ่า
					if NA[rn] then
						if CONFIG.AutoRerollRace then Reroll() else _G.RaceV2Done = true end
						return
					end

					-- เช็กครั้งเดียวว่า Orb ค้างอยู่ในคลังไหม (เช่น เก็บไว้ตั้งแต่รอบก่อน)
					if not orbOwned and not probed and not FindOrb() then
						probed = true
						_G.RaceV2Status = "Race V2: Checking Orb"
						pcall(function()
							RS:WaitForChild("OtherEvent"):WaitForChild("ItemEvents"):WaitForChild("UpdateInventory")
								:InvokeServer("Item", { Action = "Unstore", SelectedItem = "Awakening Orb" })
						end)
						local t0 = tick()
						while not FindOrb() and tick() - t0 < 2 do task.wait(0.2) end
					end
					if FindOrb() then orbOwned = true end

					-- มี Orb -> ใช้
					if orbOwned then
						local r = TryOrb()
						if r == "v2" then
							_G.RaceV2Done = true
							print("[RaceV2] เผ่าเป็น V2 แล้ว")
						elseif r == "na" then
							MarkNA(rn)
							warn("[RaceV2] Orb ไม่หายหลังใช้ -> เผ่า " .. tostring(rn) .. " อัพไม่ได้ เก็บ Orb กลับคลังแล้ว")
							if not CONFIG.AutoRerollRace then _G.RaceV2Done = true end
						elseif r == "none" then
							orbOwned = false          -- ไม่มี Orb จริง -> กลับไปทำเควส
						else
							_G.RaceV2Done = true      -- Orb หายแต่เผ่ายังไม่เป็น V2 ภายใน 5 วินาที สถานะไม่ชัด หยุดกันวนมั่ว
							warn("[RaceV2] Orb หายแต่ยังไม่เห็นเผ่าเป็น V2 หยุดโหมดนี้ (เช็กเผ่าเองอีกที)")
						end
						return
					end

					-- ยังไม่มี Orb -> ทำเควส Sogga
					if not HasSoggaQuest() then
						if not TakeQuest() then task.wait(3) return end
					end
					FarmSogga()
					-- เควสจบ (ช่องเควสหาย) -> Orb เข้าคลัง -> รอบถัดไปจะ Unstore + ใช้
					if RaceActive() and not HasSoggaQuest() then
						_G.RaceV2Status = "Race V2: Quest Complete"
						orbOwned = true
						task.wait(1)
					end
				end)
			end
		end
	end)

	-- ตัวคุมโหมด: เข้าเมื่อเข้าเงื่อนไข (ไม่แทรกกลางเรด) / ออกเมื่อไม่เข้าเงื่อนไขติดกัน 2 วินาที
	task.spawn(function()
		local offCount = 0
		while task.wait(1) do
			pcall(function()
				if RaceV2Wanted() then
					offCount = 0
					if not _G.RaceV2 and not _G.Raid and not RaidGuiVisible() then
						_G.RaceV2 = true
						_G.EvilNoob = false
						_G.ItemQuest = false
						_G.Pumpkin = false
						_G.AutoFarm = false
						StartMagnet = false
						print("[RaceV2] เข้าโหมด Race V2")
					end
				else
					offCount = offCount + 1
					if _G.RaceV2 and offCount >= 2 then
						_G.RaceV2 = false
						_G.RaceV2Status = nil
						StartMagnet = false
						HoverOrigin = nil
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
						print("[RaceV2] ออกจากโหมด Race V2")
					end
				end
			end)
		end
	end)
end

-- ===================== Flame Katana =====================
-- เลเวล FlameKatanaMinLevel+ :
--   1) มี Flame Katana ในกระเป๋าแล้ว -> จบ / ไม่มี -> Unstore ออกจากคลัง
--   2) ยังไม่ได้ -> ไปซื้อที่จุดขาย (จุดเดิมของ Cheems)
--   3) ซื้อแล้วยังไม่ได้ -> ไปตี Walter Dog 1 ตัว แล้ววนกลับไปข้อ 1 จนกว่าจะได้ดาบ
do
	local KATANA = "Flame Katana"
	local UI_KEY = "Weapon: Flame Katana"
	local SELLER_POS = CFrame.new(111.174164, -3.414658, -1575.120850)
	local BUY_ARGS = { "Weapon_Seller", "Cheems" }   -- ใช้ args เดิมของจุดขายนี้ ถ้า remote ซื้อดาบจริงต่างจากนี้ให้แก้ตรงนี้
	local DOG = "Walter Dog"
	local DOG_FALLBACK = CFrame.new(10.436995506286621, -37.043067932128906, -1034.9451904296875)

	local function FlameActive() return _G.XH_Auto and _G.FlameKatana and not _G.Raid end

	local function HaveKatana()
		local c = LocalPlayer.Character
		return (FindTool(KATANA)) ~= nil
	end

	-- กดเอาออกจากคลัง แล้วรอให้ดาบเข้ากระเป๋า
	local function Unstore()
		pcall(function()
			RS:WaitForChild("OtherEvent"):WaitForChild("ItemEvents"):WaitForChild("UpdateInventory")
				:InvokeServer("Weapon", { SelectedItem = KATANA })
		end)
		local t0 = tick()
		while not HaveKatana() and tick() - t0 < 3 do task.wait(0.2) end
		return HaveKatana()
	end

	-- ตี Walter Dog 1 ตัว (ไม่เจอ/ไม่ตายภายใน 150 วินาที ก็คืน false แล้วให้วนรอบใหม่)
	local function KillWalterDog()
		local t0 = tick()
		while FlameActive() and tick() - t0 < 150 do
			WaitBusy()
			if IsDead() then
				task.wait(1)
			else
				local mob, hum, root = FindAlive(DOG)
				if mob then
					_G.FlameStatus = "Flame Katana: Fighting " .. DOG
					repeat
						task.wait()
						WaitBusy()
						if IsDead() then break end
						if CONFIG.RaidSmart then MaybeRetreat() end
						StartMagnet = true
						PosMon = root.CFrame
						Mon = DOG
						AttackStep(root)
					until not FlameActive() or not mob.Parent or hum.Health <= 0
					StartMagnet = false
					if hum.Health <= 0 then return true end
				else
					_G.FlameStatus = "Flame Katana: Waiting " .. DOG
					pcall(TP, SpawnLocation(DOG) or DOG_FALLBACK)
					task.wait(0.3)
				end
			end
		end
		return false
	end

	local function Cycle()
		_G.FlameStatus = "Flame Katana: Checking bag"
		if HaveKatana() or Unstore() then return true end
		if not FlameActive() then return false end

		_G.FlameStatus = "Flame Katana: Buying"
		StartMagnet = false
		TP(SELLER_POS)
		task.wait(0.6)
		pcall(function()
			RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
				:FireServer(unpack(BUY_ARGS))
		end)
		task.wait(1.2)
		if Unstore() then return true end
		if not FlameActive() then return false end

		-- ซื้อแล้วแต่ยังไม่ได้ดาบ -> ไปตี Walter Dog ก่อน แล้ววนใหม่
		KillWalterDog()
		return false
	end

	task.spawn(function()
		local cycles = 0
		while task.wait(0.3) do
			if FlameActive() then
				pcall(function()
					WaitBusy()
					if IsDead() then return end
					cycles = cycles + 1
					if cycles > CONFIG.FlameKatanaMaxCycles then
						_G.FlameDone = true
						warn("[FlameKatana] วนครบ " .. CONFIG.FlameKatanaMaxCycles .. " รอบแล้วยังไม่ได้ดาบ หยุดโหมดนี้")
						return
					end
					print("[FlameKatana] รอบที่", cycles)
					if Cycle() then
						SetDone(UI_KEY)
						_G.FlameDone = true
						print("[FlameKatana] ได้ Flame Katana แล้ว")
					end
				end)
			end
		end
	end)

	-- ตัวคุมโหมด: เข้าเมื่อเข้าเงื่อนไข (ไม่แทรกกลางเรด) / ออกเมื่อไม่เข้าเงื่อนไขติดกัน 2 วินาที
	task.spawn(function()
		local offCount = 0
		while task.wait(1) do
			pcall(function()
				if HaveKatana() then SetDone(UI_KEY) end   -- มีดาบอยู่แล้ว -> ไฟเขียวใน UI
				if FlameWanted() then
					offCount = 0
					if not _G.FlameKatana and not _G.Raid and not RaidGuiVisible() then
						_G.FlameKatana = true
						_G.EvilNoob = false
						_G.ItemQuest = false
						_G.RaceV2 = false
						_G.Pumpkin = false
						_G.AutoFarm = false
						StartMagnet = false
						print("[FlameKatana] เข้าโหมด Flame Katana")
					end
				else
					offCount = offCount + 1
					if _G.FlameKatana and offCount >= 2 then
						_G.FlameKatana = false
						_G.FlameStatus = nil
						StartMagnet = false
						HoverOrigin = nil
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
						print("[FlameKatana] ออกจากโหมด Flame Katana")
					end
				end
			end)
		end
	end)
end

-- ===================== Baller Fighting Style (เงินถึง BallerMoney) =====================
-- ซื้อหมัด Baller -> เช็กกระเป๋า -> ไม่มี = ยังไม่ได้ซื้อ -> ไปฟาร์มมอน Baller BallerKills ตัว -> กลับไปซื้อใหม่ วนจนได้
do
	local BUY_POS  = CFrame.new(1713.286987, -76.123375, -4726.944336)
	local FARM_POS = CFrame.new(1306.447998, -54.330990, -4598.696289)
	local BUY_ARGS = { "FightingStyle_Teacher", "Baller" }
	local MOB      = "Baller"
	local UI_KEY    = "Fighting Style: Baller"
	local SAVE_NAME = "MemeSea_Baller_" .. LocalPlayer.UserId .. ".json"

	local function BallerActive() return _G.XH_Auto and _G.Baller and not _G.Raid end

	local function MarkDone(save)
		_G.BallerDone = true
		SetDone(UI_KEY)
		if save and writefile then pcall(writefile, SAVE_NAME, "{\"done\":true}") end
	end

	-- เคยซื้อแล้ว (จากไฟล์เซฟ) -> ไฟเขียวชั่วคราว แล้วตรวจจริงด้านล่าง (ไม่เจอหมัดจริง = ยกเลิก)
	local fromFile = false
	pcall(function()
		if SavedFlag(SAVE_NAME) then fromFile = true MarkDone(false) print("[Baller] ไฟล์เซฟบอกว่าซื้อแล้ว -> กำลังตรวจของจริง") end
	end)
	if BallerHave() then MarkDone(true) fromFile = false end

	if fromFile then
		task.spawn(function()
			pcall(WaitToolsLoaded, 20)
			local t0 = tick()
			while tick() - t0 < 30 do
				if BallerHave() then MarkDone(true) print("[Baller] ตรวจแล้วมีหมัด Baller จริง") return end
				task.wait(0.5)
			end
			-- 30 วิหลังตัวละครโหลดแล้วยังไม่มีหมัดจริง -> ไฟล์เซฟไม่ตรงความจริง
			_G.BallerDone = false
			SetLive(UI_KEY, false)
			if writefile then pcall(writefile, SAVE_NAME, '{"done":false}') end
			warn("[Baller] ไฟล์เซฟบอกว่าซื้อแล้ว แต่ไม่พบหมัด Baller -> ยกเลิกสถานะ จะซื้อใหม่เมื่อเงินถึง")
		end)
	end

	-- ซื้อ แล้วเช็กว่ามี Baller ในกระเป๋า/ในมือไหม (มี = ซื้อสำเร็จ / ไม่มี = ยังไม่ได้ซื้อ)
	local function TryBuy()
		_G.BallerStatus = "Baller: Buying"
		StartMagnet = false
		TP(BUY_POS)
		task.wait(0.6)
		pcall(function()
			RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
				:FireServer(unpack(BUY_ARGS))
		end)
		local t0 = tick()
		while not BallerHave() and tick() - t0 < 3 do task.wait(0.2) end
		return BallerHave()
	end

	-- ฟาร์ม Baller ให้ครบ CONFIG.BallerKills ตัว (หมดเวลา 240 วิ ก็กลับไปซื้อใหม่)
	local function FarmBallers()
		local kills, t0 = 0, tick()
		while BallerActive() and kills < CONFIG.BallerKills and tick() - t0 < 240 do
			WaitBusy()
			if IsDead() then
				task.wait(1)
			else
				local mob, hum, root = FindAlive(MOB)
				if mob then
					_G.BallerStatus = string.format("Baller: Farming %d/%d", kills, CONFIG.BallerKills)
					repeat
						task.wait()
						WaitBusy()
						if IsDead() then break end
						if CONFIG.RaidSmart then MaybeRetreat() end
						StartMagnet = true
						PosMon = root.CFrame
						Mon = MOB
						AttackStep(root)
					until not BallerActive() or not mob.Parent or hum.Health <= 0
					StartMagnet = false
					if hum.Health <= 0 then kills = kills + 1 end
				else
					_G.BallerStatus = "Baller: Waiting spawn"
					pcall(TP, FARM_POS)
					task.wait(0.3)
				end
			end
		end
		StartMagnet = false
		return kills
	end

	task.spawn(function()
		while task.wait(0.3) do
			if BallerActive() then
				pcall(function()
					WaitBusy()
					if IsDead() then return end
					if BallerHave() then MarkDone(true) return end
					if TryBuy() then
						MarkDone(true)
						print("[Baller] ได้หมัด Baller แล้ว")
						return
					end
					if not BallerActive() then return end
					print("[Baller] ยังไม่มีในกระเป๋า -> ไปฟาร์ม Baller " .. CONFIG.BallerKills .. " ตัว")
					_G.BallerStatus = "Baller: Going to farm"
					TP(FARM_POS)
					task.wait(0.5)
					FarmBallers()
				end)
			end
		end
	end)

	-- ตัวคุมโหมด: เข้าเมื่อเงินถึงเกณฑ์ (ไม่แทรกกลางเรด) / ออกเมื่อไม่เข้าเงื่อนไขติดกัน 2 วินาที
	task.spawn(function()
		local offCount = 0
		while task.wait(1) do
			pcall(function()
				if BallerWanted() then
					offCount = 0
					if not _G.Baller and not _G.Raid and not RaidGuiVisible() then
						_G.Baller = true
						_G.FlameKatana = false
						_G.EvilNoob = false
						_G.ItemQuest = false
						_G.RaceV2 = false
						_G.Pumpkin = false
						_G.AutoFarm = false
						StartMagnet = false
						print("[Baller] เข้าโหมดซื้อหมัด Baller")
					end
				else
					offCount = offCount + 1
					if _G.Baller and offCount >= 2 then
						_G.Baller = false
						_G.BallerStatus = nil
						StartMagnet = false
						HoverOrigin = nil
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
						print("[Baller] ออกจากโหมด Baller")
					end
				end
			end)
		end
	end)
end

-- ===================== Auto Haki (Aura Master) =====================
-- เงินถึง AuraMoney -> วาปซื้อ Aura Master -> เปิดฮาคิ -> เช็ก Character.AuraColor_Folder (มีของข้างใน = เปิดได้ / ว่าง = ยังไม่ได้ซื้อ)
-- ซื้อไม่ได้ = ต้องรอบอส MeMe เกิด: ระหว่างรอทำอย่างอื่น (ฟาร์มปกติ) พอบอสเกิดค่อยไปตี แล้วกลับมาซื้อซ้ำ วนจนกว่าจะได้
do
	local BUY_POS  = CFrame.new(6961.393066, 30.827995, 4922.719238)
	local BUY_ARGS = { "Ability_Teacher", "Aura Master" }
	local UI_KEY    = "Ability: Aura Master"
	local SAVE_NAME = "MemeSea_Aura_" .. LocalPlayer.UserId .. ".json"

	local function AuraFolder()
		local c = LocalPlayer.Character
		local f = c and c:FindFirstChild("AuraColor_Folder")
		if f then return f end
		local ok, r = pcall(function() return workspace.Character[LocalPlayer.Name].AuraColor_Folder end)
		return ok and r or nil
	end

	-- ฮาคิเปิดอยู่ = มีโฟลเดอร์ย่อยใน AuraColor_Folder
	local function AuraOn()
		local f = AuraFolder()
		return f ~= nil and #f:GetChildren() > 0
	end

	local function EnableAura()
		pcall(function()
			RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Ability"):InvokeServer("Aura")
		end)
	end

	local function MarkDone(save)
		_G.AuraDone = true
		_G.AuraTask = nil
		_G.AuraNeedBoss = false
		SetDone(UI_KEY)
		if save and writefile then pcall(writefile, SAVE_NAME, "{\"done\":true}") end
	end

	-- บอสที่ต้องตี: ชื่อ AuraBossName (หรือ Meme Beast) ที่ยังมีชีวิตใน workspace.Monster
	local function BossFind()
		local folder = workspace:FindFirstChild("Monster")
		if not folder then return end
		local want = string.lower(CONFIG.AuraBossName or "Meme Beast")
		for _, m in ipairs(folder:GetChildren()) do
			local n = string.lower(m.Name)
			if n == want then
				local hum, root = m:FindFirstChild("Humanoid"), m:FindFirstChild("HumanoidRootPart")
				if hum and root and hum.Health > 0 then return m, hum, root end
			end
		end
	end

	pcall(function()
		if SavedFlag(SAVE_NAME) then
			_G.AuraFromFile = true   -- คำใบ้จากไฟล์ ยังไม่ยืนยัน -> ตัวเช็กตอนเริ่มด้านล่างจะตรวจจริง
			MarkDone(false)
			print("[Haki] ไฟล์เซฟบอกว่าซื้อ Aura Master แล้ว -> กำลังตรวจของจริง")
		end
	end)

	local function AuraActive() return _G.XH_Auto and _G.Aura and not _G.Raid and _G.AuraTask ~= nil end

	-- ซื้อ + เปิดฮาคิ แล้วเช็กโฟลเดอร์ (true = เปิดได้แล้ว)
	local function TryBuyAura()
		_G.AuraStatus = "Haki: Buying"
		StartMagnet = false
		if AuraOn() then return true end                 -- เปิดอยู่แล้ว ไม่ต้องสลับซ้ำ
		TP(BUY_POS)
		task.wait(0.6)
		pcall(function()
			RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
				:FireServer(unpack(BUY_ARGS))
		end)
		task.wait(0.6)
		EnableAura()
		local t0 = tick()
		while not AuraOn() and tick() - t0 < 3 do task.wait(0.2) end
		return AuraOn()
	end

	local function FightBoss()
		local t0 = tick()
		while AuraActive() and _G.AuraTask == "boss" and tick() - t0 < 300 do
			WaitBusy()
			if IsDead() then task.wait(1) else
				local mob, hum, root = BossFind()
				if not mob then return true end          -- บอสหายไป (ตายแล้ว)
				_G.AuraStatus = "Haki: Boss " .. mob.Name
				repeat
					task.wait()
					WaitBusy()
					if IsDead() then break end
					if CONFIG.RaidSmart then MaybeRetreat() end
					StartMagnet = false
					AttackStep(root)
				until not AuraActive() or not mob.Parent or hum.Health <= 0
				StartMagnet = false
			end
		end
		return BossFind() == nil
	end

	task.spawn(function()
		while task.wait(0.3) do
			if AuraActive() then
				pcall(function()
					WaitBusy()
					if IsDead() then return end
					if _G.AuraTask == "buy" then
						-- ครั้งแรกต้องมีเงินพอก่อน (เช่น เพิ่งซื้อ Baller ไป เงินอาจลดลง)
						if not _G.AuraNeedBoss and (ReadMoney() or 0) < CONFIG.AuraMoney then
							_G.AuraTask = nil
							return
						end
						if TryBuyAura() then
							MarkDone(true)
							print("[Haki] เปิดฮาคิได้แล้ว")
							return
						end
						if not AuraActive() then return end
						_G.AuraTried = true
						_G.AuraNeedBoss = true
						_G.AuraTask = nil
						_G.AuraStatus = nil
						print("[Haki] ซื้อไม่ได้ -> รอบอส " .. tostring(CONFIG.AuraBossName) .. " เกิด (ระหว่างนี้ทำอย่างอื่น)")
					elseif _G.AuraTask == "boss" then
						if FightBoss() and not IsDead() then
							_G.AuraTask = "buy"          -- ตีบอสจบ -> กลับไปซื้อซ้ำ
						elseif not BossFind() then
							_G.AuraTask = nil
						end
					end
				end)
			end
		end
	end)

	-- ตัวคุมโหมด + ตัวตัดสินใจว่าตอนนี้ควรทำอะไร
	task.spawn(function()
		local offCount, wasAlive = 0, false
		while task.wait(1) do
			pcall(function()
				if CONFIG.AutoHaki and not _G.AuraDone and _G.AuraProbed then
					if AuraOn() then
						MarkDone(true)
						print("[Haki] ฮาคิเปิดอยู่แล้ว (AuraColor_Folder มีของ)")
					else
						local alive = BossFind() ~= nil
						-- บอสที่รออยู่ตาย (ใครตีก็ตาม) -> ไปซื้อซ้ำ
						if _G.AuraNeedBoss and wasAlive and not alive and _G.AuraTask == nil then
							_G.AuraTask = "buy"
						end
						wasAlive = alive
						if _G.AuraTask == nil then
							if not _G.AuraTried then
								local m = ReadMoney()
								if m and m >= CONFIG.AuraMoney then _G.AuraTask = "buy" end
							elseif _G.AuraNeedBoss and alive then
								_G.AuraTask = "boss"
							end
						end
					end
				end

				if AuraWanted() then
					offCount = 0
					if not _G.Aura and not _G.Raid and not RaidGuiVisible() then
						_G.Aura = true
						_G.FlameKatana = false
						_G.EvilNoob = false
						_G.ItemQuest = false
						_G.RaceV2 = false
						_G.Pumpkin = false
						_G.AutoFarm = false
						StartMagnet = false
						print("[Haki] เข้าโหมด Auto Haki:", _G.AuraTask)
					end
				else
					offCount = offCount + 1
					if _G.Aura and offCount >= 2 then
						_G.Aura = false
						_G.AuraStatus = nil
						StartMagnet = false
						HoverOrigin = nil
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
						print("[Haki] ออกจากโหมด Auto Haki")
					end
				end
			end)
		end
	end)

	-- ตอนเริ่มสคริป (ก่อนทำอย่างอื่นของ Auto Haki): เช็กฮาคิทันที เผื่อผู้เล่นซื้อไปแล้ว
	--   1) โฟลเดอร์ AuraColor_Folder มีของข้างใน = เปิดอยู่/ซื้อแล้ว
	--   2) ว่าง -> ลองเปิดฮาคิ 1 ครั้งแล้วเช็กโฟลเดอร์ใหม่ (มีของ = ซื้อไว้แล้วแต่ยังไม่ได้เปิด / ว่าง = ยังไม่ได้ซื้อ)
	-- ระหว่างเช็กยังไม่ให้ตัวคุมโหมดสั่งซื้อ (AuraProbed) จะได้ไม่วาปไปซื้อซ้ำทั้งที่ซื้อไว้แล้ว
	_G.AuraProbed = false
	task.spawn(function()
		pcall(function()
			if not CONFIG.AutoHaki or (_G.AuraDone and not _G.AuraFromFile) then return end
			local t0 = tick()
			-- รอตัวละครโหลด + โฟลเดอร์ฮาคิโผล่ (สูงสุด 15 วิ)
			while tick() - t0 < 15 do
				local c = LocalPlayer.Character
				if c and c:FindFirstChild("Humanoid") and c:FindFirstChild("HumanoidRootPart") and AuraFolder() then break end
				task.wait(0.25)
			end
			if AuraOn() then
				MarkDone(true)
				print("[Haki] เช็กตอนเริ่ม: ฮาคิเปิดอยู่แล้ว -> มี Aura Master")
				return
			end
			for _ = 1, 2 do   -- ลอง 2 รอบ กันพลาดเพราะสกิลยังไม่พร้อม/ตัวละครเพิ่งเกิด
				EnableAura()
				local t1 = tick()
				while not AuraOn() and tick() - t1 < 3 do task.wait(0.2) end
				if AuraOn() then break end
				task.wait(1.5)
			end
			if AuraOn() then
				_G.AuraFromFile = false
				MarkDone(true)
				print("[Haki] เช็กตอนเริ่ม: เปิดฮาคิได้ -> ซื้อ Aura Master ไว้แล้ว")
			else
				print("[Haki] เช็กตอนเริ่ม: ฮาคิเปิดไม่ได้ -> ยังไม่ได้ซื้อ")
				if _G.AuraFromFile then   -- ไฟล์เซฟบอกว่าซื้อแล้ว แต่เปิดฮาคิไม่ได้จริง -> ยกเลิกสถานะ
					_G.AuraFromFile = false
					_G.AuraDone = false
					SetLive(UI_KEY, false)
					if writefile then pcall(writefile, SAVE_NAME, '{"done":false}') end
					warn("[Haki] ไฟล์เซฟบอกว่าซื้อ Aura Master แล้ว แต่เปิดฮาคิไม่ได้ -> ยกเลิกสถานะ จะซื้อใหม่เมื่อเงินถึง")
				end
			end
		end)
		_G.AuraProbed = true
	end)

	-- ตอนเริ่มสคริป: เช็กเผ่า V2 ทันที (GUI บอก V1/อ่านไม่ได้ -> เช็กจาก Cooldown) เจอ V2 = UI ขึ้น V2 + ข้ามโหมด Race V2
	task.spawn(function()
		pcall(function()
			local t0 = tick()
			while tick() - t0 < 15 do
				local c = LocalPlayer.Character
				if c and c:FindFirstChild("Humanoid") and c:FindFirstChild("HumanoidRootPart") then break end
				task.wait(0.25)
			end
			task.wait(1)
			local _, ver = ReadRace()
			if ver ~= 2 then ver = ProbeRaceV2(true) end
			if ver == 2 then
				_G.RaceV2Done = true
				print("[Race] เช็กตอนเริ่ม: เผ่าเป็น V2 แล้ว")
			else
				print("[Race] เช็กตอนเริ่ม: เผ่ายังเป็น V1")
			end
		end)
	end)

	-- ซื้อแล้ว: ฮาคิหลุด (ตาย/รีสปอว์น) -> เปิดใหม่
	task.spawn(function()
		while task.wait(5) do
			pcall(function()
				if CONFIG.AutoHakiKeepOn and _G.AuraDone and not _G.Raid and not _G.HakiReroll and not IsDead() and not AuraOn() then
					EnableAura()
				end
			end)
		end
	end)
end

-- ===================== Auto Haki Color Reroll =====================
-- ทำ Baller / Flame Katana / Yellow Blade / Pink Hammer / Banana / Purple Katana ครบ + มี Aura Master แล้ว
--   -> วาร์ปไป HAKI_POS -> ยิง Reroll_Color ซ้ำ ๆ จน Gem หมด (จับจาก Gem ที่ไม่ลดหลังสุ่ม) -> โชว์สีที่ได้ในแผง HAKI REROLL
-- สีอ่านจาก workspace.Character.<ชื่อเรา>.AuraColor_Folder.LeftHand_AuraColor
do
	local HAKI_POS = CFrame.new(5149.385742, -83.470528, -1390.509277)

	local function GemNow()
		local ok, v = pcall(function() return LocalPlayer.PlayerData.Gem.Value end)
		return ok and v or nil
	end

	local function AuraFolder()
		local c = LocalPlayer.Character
		local f = c and c:FindFirstChild("AuraColor_Folder")
		if f then return f end
		local ok, r = pcall(function() return workspace.Character[LocalPlayer.Name].AuraColor_Folder end)
		return ok and r or nil
	end

	-- อ่านสีจากออบเจกต์ใดก็ได้ (Color3Value / BasePart / ParticleEmitter / Light ฯลฯ)
	local function ColorOf(o)
		local ok, v = pcall(function() return o.Color end)
		if ok then
			if typeof(v) == "Color3" then return v end
			if typeof(v) == "ColorSequence" and #v.Keypoints > 0 then return v.Keypoints[1].Value end
		end
		if o:IsA("Color3Value") then return o.Value end
		if o:IsA("Highlight") then return o.FillColor end
	end

	local function ReadAuraColor()
		local f = AuraFolder()
		local inst = f and f:FindFirstChild("LeftHand_AuraColor")
		if not inst then return nil end
		local c = ColorOf(inst)
		if c then return c end
		for _, d in ipairs(inst:GetDescendants()) do
			c = ColorOf(d)
			if c then return c end
		end
	end

	-- ชื่อสีภาษาอังกฤษที่ใกล้ที่สุด
	local PALETTE = {
		{ "Red", 255, 0, 0 }, { "Dark Red", 139, 0, 0 }, { "Crimson", 220, 20, 60 }, { "Maroon", 110, 0, 20 },
		{ "Orange", 255, 140, 0 }, { "Peach", 255, 180, 130 }, { "Gold", 255, 200, 0 }, { "Yellow", 255, 255, 0 },
		{ "Lime", 150, 255, 0 }, { "Green", 0, 200, 0 }, { "Dark Green", 0, 100, 0 }, { "Mint", 120, 255, 190 },
		{ "Teal", 0, 128, 128 }, { "Turquoise", 64, 224, 208 }, { "Cyan", 0, 255, 255 }, { "Sky Blue", 100, 190, 255 },
		{ "Blue", 0, 0, 255 }, { "Royal Blue", 65, 105, 225 }, { "Navy", 0, 0, 128 }, { "Indigo", 75, 0, 130 },
		{ "Purple", 128, 0, 200 }, { "Violet", 170, 100, 255 }, { "Lavender", 200, 180, 255 }, { "Magenta", 255, 0, 255 },
		{ "Pink", 255, 150, 200 }, { "Hot Pink", 255, 60, 150 }, { "Brown", 120, 70, 30 },
		{ "White", 255, 255, 255 }, { "Silver", 190, 190, 190 }, { "Gray", 128, 128, 128 },
		{ "Dark Gray", 64, 64, 64 }, { "Black", 0, 0, 0 },
	}
	local function ColorName(c3)
		local r, g, b = c3.R * 255, c3.G * 255, c3.B * 255
		local best, bd = "Unknown", math.huge
		for _, p in ipairs(PALETTE) do
			local d = 2 * (r - p[2]) ^ 2 + 4 * (g - p[3]) ^ 2 + 3 * (b - p[4]) ^ 2
			if d < bd then best, bd = p[1], d end
		end
		return best
	end
	local function Hex(c3)
		return string.format("#%02X%02X%02X", math.floor(c3.R * 255 + 0.5), math.floor(c3.G * 255 + 0.5), math.floor(c3.B * 255 + 0.5))
	end

	-- ---------- แผง HAKI REROLL ----------
	local UI
	local function BuildUI()
		if UI then return UI end
		local UIS = game:GetService("UserInputService")
		local C = {
			bg1 = Color3.fromRGB(16, 21, 38), bg2 = Color3.fromRGB(9, 12, 22), card = Color3.fromRGB(20, 27, 48),
			row = Color3.fromRGB(24, 32, 56), line = Color3.fromRGB(36, 46, 76), gray = Color3.fromRGB(120, 132, 168),
			white = Color3.fromRGB(240, 244, 255), blue = Color3.fromRGB(70, 190, 255), violet = Color3.fromRGB(125, 120, 255),
			green = Color3.fromRGB(70, 235, 130),
		}
		local gui = Instance.new("ScreenGui")
		gui.Name = "XHHubHakiUI"; gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true
		gui.DisplayOrder = 998; gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		pcall(function() if syn and syn.protect_gui then syn.protect_gui(gui) end end)
		local parented = false
		pcall(function() gui.Parent = (gethui and gethui()) or game:GetService("CoreGui"); parented = true end)
		if not parented then gui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

		local function corner(o, r) local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r); c.Parent = o end
		local function stroke(o, col, th, tr)
			local s = Instance.new("UIStroke"); s.Color = col; s.Thickness = th; s.Transparency = tr or 0
			s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.Parent = o
		end
		local function frame(p, x, y, w, h, col)
			local f = Instance.new("Frame"); f.Position = UDim2.fromOffset(x, y); f.Size = UDim2.fromOffset(w, h)
			f.BackgroundColor3 = col; f.BorderSizePixel = 0; f.Parent = p
			return f
		end
		local function label(p, text, size, col, x, y, w, h, font, align)
			local t = Instance.new("TextLabel"); t.BackgroundTransparency = 1; t.Text = text; t.TextSize = size
			t.TextColor3 = col; t.Font = font or Enum.Font.Gotham; t.TextXAlignment = align or Enum.TextXAlignment.Left
			t.Position = UDim2.fromOffset(x, y); t.Size = UDim2.fromOffset(w, h); t.Parent = p
			return t
		end

		local W, H = 250, 340
		local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(800, 400)
		local main = frame(gui, math.max(0, vp.X - W - 12), 70, W, H, C.bg1)
		main.Active = true; corner(main, 14); stroke(main, C.violet, 1.5, 0.55)
		local g = Instance.new("UIGradient"); g.Color = ColorSequence.new(C.bg1, C.bg2); g.Rotation = 90; g.Parent = main
		local scale = Instance.new("UIScale"); scale.Parent = main
		local function fit()
			local cam = workspace.CurrentCamera
			if not cam then return end
			local v = cam.ViewportSize
			scale.Scale = math.min(1, (v.X * 0.6) / W, (v.Y * 0.88) / H)
		end
		fit()
		if workspace.CurrentCamera then workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fit) end

		-- ลากย้ายแผงได้
		do
			local dragging, dragStart, startPos = false, nil, nil
			main.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging, dragStart, startPos = true, input.Position, main.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then dragging = false end
					end)
				end
			end)
			UIS.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					local d = input.Position - dragStart
					main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X / scale.Scale, startPos.Y.Scale, startPos.Y.Offset + d.Y / scale.Scale)
				end
			end)
		end

		label(main, "RANDOM MÀU HAKI", 14, C.white, 14, 10, 222, 22, Enum.Font.GothamBold)
		local div = frame(main, 14, 36, W - 28, 2, C.blue)
		local dg = Instance.new("UIGradient"); dg.Color = ColorSequence.new(C.blue, C.violet); dg.Parent = div

		local gemCard = frame(main, 14, 46, 108, 46, C.card); corner(gemCard, 8)
		label(gemCard, "GEM CÒN", 10, C.gray, 10, 4, 90, 14, Enum.Font.GothamMedium)
		local gemV = label(gemCard, "-", 17, C.white, 10, 20, 90, 22, Enum.Font.GothamBold)
		local rollCard = frame(main, 128, 46, 108, 46, C.card); corner(rollCard, 8)
		label(rollCard, "SỐ LẦN", 10, C.gray, 10, 4, 90, 14, Enum.Font.GothamMedium)
		local rollV = label(rollCard, "0", 17, C.green, 10, 20, 90, 22, Enum.Font.GothamBold)

		local curCard = frame(main, 14, 100, W - 28, 46, C.card); corner(curCard, 8)
		label(curCard, "HIỆN TẠI", 10, C.gray, 10, 4, 90, 14, Enum.Font.GothamMedium)
		local curSw = frame(curCard, 10, 20, 20, 20, C.off or Color3.fromRGB(58, 66, 94)); corner(curSw, 6)
		stroke(curSw, C.white, 1, 0.6)
		local curV = label(curCard, "-", 15, C.white, 38, 18, 190, 24, Enum.Font.GothamBold)

		label(main, "MÀU ĐÃ CÓ", 10, C.gray, 16, 152, 160, 14, Enum.Font.GothamMedium)
		local listCard = frame(main, 14, 168, W - 28, 124, C.card); corner(listCard, 8)
		local scroller = Instance.new("ScrollingFrame")
		scroller.BackgroundTransparency = 1; scroller.BorderSizePixel = 0
		scroller.Position = UDim2.fromOffset(0, 4); scroller.Size = UDim2.new(1, 0, 1, -8)
		scroller.CanvasSize = UDim2.fromOffset(0, 0); scroller.ScrollBarThickness = 4
		scroller.ScrollBarImageColor3 = C.violet; scroller.Active = true
		scroller.ScrollingDirection = Enum.ScrollingDirection.Y; scroller.Parent = listCard

		local bar = frame(main, 14, 300, W - 28, 28, C.card); corner(bar, 8)
		local statusV = label(bar, "Đang chờ...", 12, C.white, 10, 0, W - 48, 28, Enum.Font.GothamMedium)

		local order, byKey = {}, {}
		local api = { rolls = 0 }
		local function lum(c) return 0.299 * c.R + 0.587 * c.G + 0.114 * c.B end
		local function textColor(c) return lum(c) < 0.35 and c:Lerp(Color3.new(1, 1, 1), 0.55) or c end

		function api.setStatus(s) statusV.Text = s end
		function api.setGem(n) gemV.Text = n and Fmt(n) or "-" end
		function api.setCurrent(c3)
			if not c3 then curV.Text = "Unknown"; return end
			curSw.BackgroundColor3 = c3
			curV.Text = ColorName(c3) .. "  " .. Hex(c3)
			curV.TextColor3 = textColor(c3)
		end
		function api.add(c3)
			api.rolls = api.rolls + 1
			rollV.Text = tostring(api.rolls)
			api.setCurrent(c3)
			if not c3 then return end
			local key = Hex(c3)
			local e = byKey[key]
			if e then
				e.count = e.count + 1
				e.cnt.Text = "x" .. e.count
				return
			end
			local y = 4 + #order * 30
			local row = frame(scroller, 6, y, W - 28 - 22, 26, C.row); corner(row, 6)
			local sw = frame(row, 6, 4, 18, 18, c3); corner(sw, 5); stroke(sw, C.white, 1, 0.6)
			label(row, ColorName(c3), 13, textColor(c3), 32, 0, 84, 26, Enum.Font.GothamBold)
			label(row, key, 10, C.gray, 118, 0, 52, 26, Enum.Font.Gotham)
			local cnt = label(row, "x1", 12, C.white, 0, 0, W - 28 - 22 - 8, 26, Enum.Font.GothamBold, Enum.TextXAlignment.Right)
			e = { count = 1, cnt = cnt }
			byKey[key] = e
			table.insert(order, key)
			scroller.CanvasSize = UDim2.fromOffset(0, 8 + #order * 30)
			scroller.CanvasPosition = Vector2.new(0, math.max(0, 8 + #order * 30 - 116))
		end
		task.spawn(function()
			while task.wait(0.5) do
				if not gui.Parent then break end
				api.setGem(GemNow())
			end
		end)
		UI = api
		return api
	end

	-- ---------- ลูปสุ่ม ----------
	local runId = 0
	local function EnsureAuraOn()
		local f = AuraFolder()
		if f and #f:GetChildren() > 0 then return end
		pcall(function()
			RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Ability"):InvokeServer("Aura")
		end)
		task.wait(1)
	end

	local function RunReroll(myId)
		local ui = BuildUI()
		local rolls, fails, cost = 0, 0, _G.HakiRerollCost
		local exhausted = false
		ui.setStatus("Đang đến Halved Sorcerer")
		while _G.HakiReroll and myId == runId do
			if _G.Raid or _G.Boss then break end
			WaitBusy()
			if IsDead() then
				ui.setStatus("Đang chờ hồi sinh")
				task.wait(1)
			else
				pcall(function()
					local hrp = LocalPlayer.Character.HumanoidRootPart
					if (hrp.Position - HAKI_POS.Position).Magnitude > 8 then TP(HAKI_POS) end
				end)
				local g0 = GemNow()
				if g0 and (g0 <= 0 or (cost and g0 < cost)) then
					exhausted = true
					break
				end
				EnsureAuraOn()
				ui.setStatus("Đang random màu Haki...")
				pcall(function()
					RS:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
						:FireServer("Reroll_Color", CONFIG.HakiRerollNPC or "Halved Sorcerer")
				end)
				-- Gem ลด = สุ่มสำเร็จ (รอสูงสุด 3 วิ)
				local t0, spent = tick(), false
				while tick() - t0 < 3 do
					local g1 = GemNow()
					if g0 and g1 and g1 < g0 then
						cost = g0 - g1
						_G.HakiRerollCost = cost
						spent = true
						break
					end
					task.wait(0.15)
				end
				if spent then
					fails = 0
					rolls = rolls + 1
					_G.HakiRerollTotal = (_G.HakiRerollTotal or 0) + 1
					task.wait(0.4)   -- ให้สีอัปเดตก่อนอ่าน
					local c3 = ReadAuraColor()
					ui.add(c3)
					ui.setGem(GemNow())
					print(string.format("[HakiReroll] #%d -> %s %s | Gem %s", rolls, c3 and ColorName(c3) or "?", c3 and Hex(c3) or "", tostring(GemNow())))
				else
					fails = fails + 1
					if fails >= 3 then exhausted = true break end
				end
				task.wait(CONFIG.HakiRerollDelay or 0.6)
			end
		end
		if exhausted then
			if (_G.HakiRerollTotal or 0) > 0 and not CONFIG.HakiRerollRepeat then
				_G.HakiRerollDone = true
				ui.setStatus("Xong - hết Gem")
			else
				_G.HakiRerollNeedGem = math.max(CONFIG.HakiRerollMinGems or 1, cost or ((GemNow() or 0) + 50))
				ui.setStatus("Hết Gem - đang chờ thêm")
			end
			print("[HakiReroll] Gem หมดแล้ว สุ่มรอบนี้ไป", rolls, "ครั้ง")
			_G.HakiReroll = false      -- ออกจากโหมด -> เรด/ฟาร์มกลับมาทำต่อ
			StartMagnet = false
			HoverOrigin = nil
			if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
		end
	end

	-- ตัวคุมโหมด
	task.spawn(function()
		local offCount = 0
		while task.wait(1) do
			pcall(function()
				if HakiRerollWanted() then
					offCount = 0
					if not _G.HakiReroll and not _G.Raid and not RaidGuiVisible() and not _G.Boss then
						_G.HakiReroll = true
						_G.FlameKatana = false
						_G.EvilNoob = false
						_G.ItemQuest = false
						_G.RaceV2 = false
						_G.Pumpkin = false
						_G.AutoFarm = false
						StartMagnet = false
						runId = runId + 1
						local myId = runId
						print("[HakiReroll] เข้าโหมดสุ่มสีฮาคิ")
						task.spawn(function() pcall(RunReroll, myId) end)
					end
				else
					offCount = offCount + 1
					if _G.HakiReroll and offCount >= 2 then
						_G.HakiReroll = false
						_G.HakiRerollStatus = nil
						StartMagnet = false
						HoverOrigin = nil
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
						print("[HakiReroll] ออกจากโหมดสุ่มสีฮาคิ")
					end
				end
			end)
		end
	end)
end

-- ===================== Evil Noob (เลเวล EvilNoobMinLevel+) =====================
-- วาร์ปไปจุด Evil Noob หามอน -> เจอ: รับเควสแล้วฟาร์ม / ไม่เจอ: ไปเสก (กด E รัวๆ) แล้ววาร์ปกลับมาเช็ก
-- ยังไม่เกิด -> ไปฟาร์ม Moai แล้วกลับไปเสก วนจนกว่าจะเกิด -> ฟาร์มจนเควสเสร็จ
-- เสร็จแล้วเช็ก Yellow Blade: Unstore แล้วถือขึ้นมือ  มีในกระเป๋า = จบ
do
	local NOOB = "Evil Noob"
	local MOAI = "Moai"
	local BLADE = "Yellow Blade"
	local NOOB_POS   = CFrame.new(3283.780273, -51.630680, 4484.267090)
	local QUEST_POS  = CFrame.new(2890.924561, -51.792477, 4207.233887)
	local SUMMON_POS = CFrame.new(-2356.497559, -75.346283, 3180.454346)
	local MOAI_POS   = CFrame.new(-2685.326172, -80.996971, 3442.507080)

	local function Active() return _G.XH_Auto and _G.EvilNoob and not _G.Raid and not _G.NoobRaidPhase end

	-- เช็กสปอว์นจาก workspace.Location.Enemy_Location (พาร์ตชื่อ = ชื่อมอน) + มอนที่มีชีวิตใน workspace.Monster
	local function NoobSpawned()
		local count = SpawnInfo(NOOB)
		return count > 0 or FindAlive(NOOB) ~= nil
	end

	local function QuestSlot()
		local ok, slot = pcall(function() return LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1 end)
		return ok and slot or nil
	end

	local function HasNoobQuest()
		local slot = QuestSlot()
		return slot and slot.Visible and string.find(string.lower(slot.Target.Text), "evil noob") ~= nil
	end

	local function HaveBlade()
		local c = LocalPlayer.Character
		return (FindTool(BLADE)) ~= nil
	end

	-- เอา Yellow Blade ออกจากคลัง แล้วถือขึ้นมือ
	local function GetBlade()
		if not HaveBlade() then
			pcall(function()
				RS:WaitForChild("OtherEvent"):WaitForChild("ItemEvents"):WaitForChild("UpdateInventory")
					:InvokeServer("Weapon", { SelectedItem = BLADE })
			end)
			local t0 = tick()
			while not HaveBlade() and tick() - t0 < 3 do task.wait(0.2) end
		end
		if not HaveBlade() then return false end
		pcall(function()
			local tool = LocalPlayer.Backpack:FindFirstChild(BLADE)
			if tool then LocalPlayer.Character.Humanoid:EquipTool(tool) end
		end)
		return true
	end

	local function TakeQuest()
		_G.EvilNoobStatus = "Evil Noob: Quest"
		StartMagnet = false
		local prompts = CollectPrompts(QUEST_POS, 25)
		for _ = 1, 10 do
			if not Active() then return false end
			WaitBusy()
			if IsDead() then return false end
			local slot = QuestSlot()
			if slot and slot.Visible then
				if HasNoobQuest() then return true end
				RS.OtherEvent.QuestEvents.Quest:FireServer("Abandon_Quest", { QuestSlot = "QuestSlot1" })
				task.wait(0.5)
			end
			TP(QUEST_POS)
			task.wait(0.3)
			PressE()
			for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
			task.wait(0.6)
		end
		return HasNoobQuest()
	end

	local function FightNoob(mob, hum, root)
		_G.EvilNoobStatus = "Evil Noob: Fighting"
		StartMagnet = false
		repeat
			task.wait()
			WaitBusy()
			if IsDead() then break end
			if CONFIG.RaidSmart then MaybeRetreat() end
			AttackStep(root)
		until not Active() or not mob.Parent or hum.Health <= 0
	end

	-- วาร์ปไปจุด Evil Noob แล้วรอดูว่าเกิดไหม
	local function CheckNoob(seconds)
		seconds = seconds or CONFIG.NoobCheckSeconds
		local t0 = tick()
		while Active() and tick() - t0 < seconds do
			pcall(TP, NOOB_POS)               -- ยืนที่จุดเกิดตลอด ให้เกมโหลดมอนมาให้เห็น
			if NoobSpawned() then return true end
			task.wait(0.2)
		end
		return NoobSpawned()
	end

	local function FarmMoai()
		_G.EvilNoobStatus = "Evil Noob: Farming Moai"
		pcall(TP, MOAI_POS)
		local kills, idle = 0, 0
		while Active() and kills < CONFIG.MoaiKills do
			WaitBusy()
			if IsDead() then
				-- ตาย/โดนรีจาก HitStuck: รอเกิดใหม่แล้วกลับมาฟาร์ม Moai ต่อ (เก็บจำนวน kills ไว้ ไม่ไปเสกก่อน)
				StartMagnet = false
				local td = tick()
				while Active() and IsDead() and tick() - td < 15 do task.wait(0.3) end
				task.wait(1)
				pcall(TP, MOAI_POS)
				idle = 0
				continue
			end
			if NoobSpawned() then break end   -- Evil Noob เกิดแล้ว -> ออกไปสู้
			local mob, hum, root = FindAlive(MOAI)
			if mob then
				idle = 0
				repeat
					task.wait()
					WaitBusy()
					if IsDead() then break end
					if CONFIG.RaidSmart then MaybeRetreat() end
					StartMagnet = true
					PosMon = root.CFrame
					Mon = MOAI
					AttackStep(root)
				until not Active() or not mob.Parent or hum.Health <= 0 or NoobSpawned()   -- Evil Noob เกิด = หยุดทันที
				StartMagnet = false
				if NoobSpawned() then break end
				-- นับว่าตายเมื่อเลือด <= 0 หรือโมเดลหายไป (บางทีโมเดลหายก่อนเลือดอัปเดต -> เดิมไม่นับ เลยไม่ไปเสกสักที)
				if (hum.Health <= 0 or not mob.Parent) and not IsDead() and Active() then
					kills = kills + 1
					print("[EvilNoob] Moai", kills, "/", CONFIG.MoaiKills)
				end
			else
				pcall(TP, SpawnLocation(MOAI) or MOAI_POS)
				task.wait(0.3)
				idle = idle + 1
				if idle > 150 then break end  -- ~45 วินาทีไม่เจอ Moai เลย -> กลับไปเสกใหม่
			end
		end
		StartMagnet = false
	end

	-- เสก: กด E รัวๆ -> วาร์ปไปเช็ก -> ยังไม่เกิดไปฟาร์ม Moai -> กลับมาเสก คืน true เมื่อ Evil Noob เกิด
	local function SummonNoob()
		for round = 1, CONFIG.EvilNoobSummonRounds do
			if not Active() then return false end
			WaitBusy()
			if IsDead() then
				task.wait(1)
			else
				if round > 1 and CheckNoob(2) then return true end   -- เกิดแล้ว -> ไปฟาร์มเลย ไม่เสกซ้ำ
				_G.EvilNoobStatus = string.format("Evil Noob: Summoning (%d)", round)
				StartMagnet = false
				TP(SUMMON_POS)
				task.wait(0.4)
				local prompts = CollectPrompts(SUMMON_POS, 25)
				for _ = 1, CONFIG.SummonPresses do   -- กด E แค่ SummonPresses รอบ แล้วไปเช็กเลย
					if not Active() then break end
					WaitBusy()
					if IsDead() then break end
					if NoobSpawned() then return true end
					pcall(TP, SUMMON_POS)
					PressE()
					for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
					task.wait(0.25)
				end
				if not Active() then return false end
				_G.EvilNoobStatus = "Evil Noob: Checking spawn"
				if CheckNoob() then return true end
				FarmMoai()
				if NoobSpawned() then return true end
			end
		end
		return NoobSpawned()
	end

	-- คืน true = ได้ Yellow Blade แล้ว
	local function Cycle()
		_G.EvilNoobStatus = "Evil Noob: Checking sword"
		if HaveBlade() or GetBlade() then return true end
		if not Active() then return false end

		-- 1) หามอน
		_G.EvilNoobStatus = "Evil Noob: Searching"
		if not CheckNoob(3) then
			if not SummonNoob() then return false end
		end

		-- 2) รับเควส
		if not HasNoobQuest() then
			if not TakeQuest() then return false end
		end

		-- 3) ฟาร์มจนเควสเสร็จ (มอนตายแล้วเควสยังอยู่ -> เสกใหม่)
		local guard = 0
		while Active() and HasNoobQuest() and guard < 20 do
			guard = guard + 1
			local mob, hum, root = FindAlive(NOOB)
			if not mob and CheckNoob(4) then mob, hum, root = FindAlive(NOOB) end   -- ไปดูจุดเกิดก่อน อย่าเพิ่งเสกซ้ำ
			if mob then
				FightNoob(mob, hum, root)
			else
				if not SummonNoob() then break end
			end
		end
		if not Active() then return false end

		-- 4) เควสเสร็จ -> เช็ก/ถือ Yellow Blade
		_G.EvilNoobStatus = "Evil Noob: Checking sword"
		task.wait(1)
		return HaveBlade() or GetBlade()
	end

	task.spawn(function()
		local cycles = 0
		while task.wait(0.3) do
			if Active() then
				pcall(function()
					WaitBusy()
					if IsDead() then return end
					print("[EvilNoob] รอบที่", cycles + 1)
					if Cycle() then
						_G.EvilNoobDone = true
						SetDone("Weapon: Yellow Blade")
						print("[EvilNoob] ได้ Yellow Blade แล้ว")
					elseif Active() then   -- นับเฉพาะรอบที่ทำจนจบ (ไม่ใช่ถูกโหมดอื่นแทรก)
						cycles = cycles + 1
						if CONFIG.EvilNoobMaxCycles > 0 and cycles >= CONFIG.EvilNoobMaxCycles then
							cycles = 0
							if CONFIG.AutoRaid then
								_G.NoobRaidPhase = true
								warn("[EvilNoob] ครบ " .. CONFIG.EvilNoobMaxCycles .. " รอบแล้วยังไม่ได้ Yellow Blade -> ไปเรดจน Gem ถึง " .. CONFIG.NoobRaidGems .. " แล้วกลับมาทำดาบ")
							end
						end
					end
				end)
			end
		end
	end)

	-- ช่วงพักไปเรด: Gem ถึง NoobRaidGems -> ซื้อ Drop Item X2 (ครั้งเดียว) -> กลับมาทำดาบ
	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				if not _G.NoobRaidPhase then return end
				if InRaidNow() then return end
				if HaveBlade() then _G.NoobRaidPhase = false return end
				local gem = LocalPlayer.PlayerData.Gem.Value
				if gem < CONFIG.NoobRaidGems then return end
				if CONFIG.AutoBuyDropX2 and not _G.DropX2Bought and not _G.DropX2Owned then
					_G.DropX2Bought = true
					pcall(function()
						RS:WaitForChild("OtherEvent"):WaitForChild("BuyEvents"):WaitForChild("BuyProduct")
							:FireServer({ Action = "Buy_Gamepass", GamepassId = CONFIG.DropX2GamepassId })
					end)
					print("[EvilNoob] Gem ถึง", CONFIG.NoobRaidGems, "-> ซื้อ Drop Item X2")
					task.wait(1.5)
				end
				_G.NoobRaidPhase = false
				print("[EvilNoob] กลับมาทำ Yellow Blade ต่อ")
			end)
		end
	end)

	-- ตัวคุมโหมด
	task.spawn(function()
		local offCount = 0
		while task.wait(1) do
			pcall(function()
				if HaveBlade() then SetDone("Weapon: Yellow Blade") end   -- มีดาบอยู่แล้ว -> ไฟเขียวใน UI
				if EvilNoobWanted() then
					offCount = 0
					if not _G.EvilNoob and not _G.Raid and not RaidGuiVisible() then
						_G.EvilNoob = true
						_G.FlameKatana = false
						_G.ItemQuest = false
						_G.RaceV2 = false
						_G.Pumpkin = false
						_G.AutoFarm = false
						StartMagnet = false
						print("[EvilNoob] เข้าโหมด Evil Noob")
					end
				else
					offCount = offCount + 1
					if _G.EvilNoob and offCount >= 2 then
						_G.EvilNoob = false
						_G.EvilNoobStatus = nil
						StartMagnet = false
						HoverOrigin = nil
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
						print("[EvilNoob] ออกจากโหมด Evil Noob")
					end
				end
			end)
		end
	end)
end

-- ===================== Item Quests (Pink Hammer / Banana / Purple Katana) =====================
-- ก่อนทำทุกอัน: เอาออกจากคลัง (UpdateInventory) มาเช็กก่อน ถ้ามีในกระเป๋า = เสร็จ
--  Pink Hammer  (เลเวล 1350+)      : ฟาร์ม Pink Absorber จนมี Pink Hammer
--  Banana       (เลเวล 800+ เงิน 350000+): ซื้อ Smiling Cat -> ไม่ได้ ไปฟาร์ม Gorilla King 1 ตัว แล้วกลับไปซื้อ วนจนกว่าจะได้
--  Purple Katana (เลเวล 1700+)     : หา Lord Sus -> เจอ: รับเควสแล้วสู้ / ไม่เจอ: ไปเสก (กด E) -> ยังไม่เกิดไปฟาร์ม Sus Duck 9 ตัว แล้วกลับไปเสก
do
	local RS_ = game:GetService("ReplicatedStorage")

	local PINK_POS      = CFrame.new(1909.125610, 121.997841, 2997.842285)
	local PINK_MOB      = "Pink Absorber"

	local BANANA_SELLER = CFrame.new(-2895.317871, -62.025990, 354.285858)
	local GORILLA_POS   = CFrame.new(-3804.777344, -91.349503, 377.166351)
	local GORILLA       = "Gorilla King"

	local LORD          = "Lord Sus"
	local DUCK          = "Sus Duck"
	local LORD_POS      = CFrame.new(6653.638184, -94.733131, 4496.267090)
	local LORD_QUEST    = CFrame.new(6565.654785, -94.791138, 4794.839355)
	local LORD_SUMMON   = CFrame.new(6644.367188, -94.872475, 4809.016113)
	local DUCK_POS      = CFrame.new(1529.334229, -51.696487, 2317.537109)

	local function Active() return _G.XH_Auto and _G.ItemQuest and not _G.Raid end
	local function KeyActive(key) return Active() and _G.ItemQuestKey == key and not _G.ItemDone[key] end   -- ได้ไอเทมแล้ว = ทุกลูปหยุดทันที
	local function Status(txt) _G.ItemQuestStatus = txt end

	-- สู้มอน 1 ตัวจนตาย  abortFn (ถ้ามี) เช็กทุก 0.5 วินาที คืน true = หยุดสู้ (เช่น ได้ไอเทมแล้ว / Lord Sus เกิดแล้ว)
	-- คืน true เมื่อมอนตาย
	local function FightOne(key, mob, hum, root, bring, abortFn)
		local nextCheck = 0
		repeat
			task.wait()
			WaitBusy()
			if IsDead() then break end
			if CONFIG.RaidSmart then MaybeRetreat() end
			if abortFn and tick() >= nextCheck then
				nextCheck = tick() + 0.5
				if abortFn() then break end
			end
			if bring then
				StartMagnet = true
				PosMon = root.CFrame
				Mon = mob.Name
			else
				StartMagnet = false
			end
			AttackStep(root)
		until not KeyActive(key) or not mob.Parent or hum.Health <= 0
		StartMagnet = false
		return hum.Health <= 0
	end

	-- ตีมอน 1 ตัว (ไม่เจอ/ไม่ตายภายใน 150 วินาที คืน false ให้วนรอบใหม่)
	local function KillOne(key, mobName, waitPos, label)
		local t0 = tick()
		while KeyActive(key) and tick() - t0 < 150 do
			WaitBusy()
			if IsDead() then
				task.wait(1)
			else
				local mob, hum, root = FindAlive(mobName)
				if mob then
					Status(label .. ": Fighting " .. mobName)
					if FightOne(key, mob, hum, root, true) then return true end
				else
					Status(label .. ": Waiting " .. mobName)
					pcall(TP, SpawnLocation(mobName) or waitPos)
					task.wait(0.3)
				end
			end
		end
		return false
	end

	-- ========================= Pink Hammer =========================
	local function PinkCycle()
		local item = ITEM_INFO.PinkHammer.name
		Status("Pink Hammer: Checking bag")
		if ItemUnstore(item, 2) then return true end
		if not KeyActive("PinkHammer") then return false end

		StartMagnet = false
		pcall(TP, PINK_POS)
		task.wait(0.5)
		local abort = function() return ItemHave(item) end
		while KeyActive("PinkHammer") do
			WaitBusy()
			if IsDead() then
				task.wait(1)
			else
				local mob, hum, root = FindAlive(PINK_MOB)
				if mob then
					Status("Pink Hammer: Fighting " .. PINK_MOB)
					FightOne("PinkHammer", mob, hum, root, true, abort)
					if hum.Health <= 0 or ItemHave(item) then
						Status("Pink Hammer: Checking bag")
						if ItemUnstore(item, 2) then return true end
					end
				else
					Status("Pink Hammer: Waiting " .. PINK_MOB)
					pcall(TP, PINK_POS)
					task.wait(0.3)
				end
			end
		end
		return false
	end

	-- ========================= Banana =========================
	local function BananaCycle()
		local item = ITEM_INFO.Banana.name
		Status("Banana: Checking bag")
		if ItemUnstore(item, 2) then return true end
		if not KeyActive("Banana") then return false end

		Status("Banana: Buying")
		StartMagnet = false
		pcall(TP, BANANA_SELLER)
		task.wait(0.6)
		pcall(function()
			RS_:WaitForChild("OtherEvent"):WaitForChild("MainEvents"):WaitForChild("Modules")
				:FireServer("Weapon_Seller", "Smiling Cat")
		end)
		task.wait(1.2)
		if ItemUnstore(item, 3) then return true end
		if not KeyActive("Banana") then return false end

		-- ซื้อไม่ได้ -> ไปฟาร์ม Gorilla King 1 ตัว แล้วกลับไปซื้อใหม่
		pcall(TP, GORILLA_POS)
		task.wait(0.4)
		KillOne("Banana", GORILLA, GORILLA_POS, "Banana")
		return false
	end

	-- ========================= Purple Katana =========================
	local function LordSpawned()
		local count = SpawnInfo(LORD)
		return count > 0 or FindAlive(LORD) ~= nil
	end

	local function QuestSlot()
		local ok, slot = pcall(function() return LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1 end)
		return ok and slot or nil
	end

	local function HasLordQuest()
		local slot = QuestSlot()
		return slot and slot.Visible and string.find(string.lower(slot.Target.Text), "lord sus") ~= nil
	end

	local function TakeLordQuest()
		Status("Purple Katana: Quest")
		StartMagnet = false
		local prompts = CollectPrompts(LORD_QUEST, 25)
		for _ = 1, 8 do
			if not KeyActive("PurpleKatana") then return false end
			WaitBusy()
			if IsDead() then return false end
			local slot = QuestSlot()
			if slot and slot.Visible then
				if HasLordQuest() then return true end
				RS_.OtherEvent.QuestEvents.Quest:FireServer("Abandon_Quest", { QuestSlot = "QuestSlot1" })
				task.wait(0.5)
			end
			pcall(TP, LORD_QUEST)
			task.wait(0.3)
			PressE()
			for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
			task.wait(0.6)
		end
		return HasLordQuest()
	end

	-- ฟาร์ม Sus Duck ให้ครบ SusDuckKills ตัว  เช็ก Lord Sus ตลอด (เกิดเมื่อไหร่หยุดทันที)  คืน true = Lord Sus เกิดแล้ว
	local function FarmDucks()
		pcall(TP, DUCK_POS)
		local kills, idle = 0, 0
		while KeyActive("PurpleKatana") and kills < CONFIG.SusDuckKills do
			WaitBusy()
			if IsDead() then break end
			if LordSpawned() then return true end
			Status(string.format("Purple Katana: Farming Sus Duck (%d/%d)", kills, CONFIG.SusDuckKills))
			local mob, hum, root = FindAlive(DUCK)
			if mob then
				idle = 0
				if FightOne("PurpleKatana", mob, hum, root, true, LordSpawned) then
					kills = kills + 1
					print("[PurpleKatana] Sus Duck", kills, "/", CONFIG.SusDuckKills)
				end
			else
				pcall(TP, SpawnLocation(DUCK) or DUCK_POS)
				task.wait(0.3)
				idle = idle + 1
				if idle > 60 then break end   -- ~18 วินาทีไม่เจอ Sus Duck -> กลับไปเสกใหม่
			end
		end
		StartMagnet = false
		return LordSpawned()
	end

	-- เสก Lord Sus: กด E รัวๆ -> ไปเช็ก -> ยังไม่เกิดไปฟาร์ม Sus Duck -> กลับมาเสก  คืน true เมื่อ Lord Sus เกิด
	local function SummonLord()
		for round = 1, CONFIG.LordSusSummonRounds do
			if not KeyActive("PurpleKatana") then return false end
			WaitBusy()
			if IsDead() then
				task.wait(1)
			else
				Status(string.format("Purple Katana: Summoning (%d)", round))
				StartMagnet = false
				pcall(TP, LORD_SUMMON)
				task.wait(0.4)
				local prompts = CollectPrompts(LORD_SUMMON, 25)
				for _ = 1, CONFIG.SummonPresses do   -- กด E แค่ SummonPresses รอบ แล้วไปเช็กเลย
					if not KeyActive("PurpleKatana") then break end
					WaitBusy()
					if IsDead() then break end
					if LordSpawned() then return true end
					pcall(TP, LORD_SUMMON)
					PressE()
					for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
					task.wait(0.25)
				end
				if not KeyActive("PurpleKatana") then return false end

				Status("Purple Katana: Checking spawn")
				pcall(TP, LORD_POS)
				local t1 = tick()
				while KeyActive("PurpleKatana") and tick() - t1 < 2 do
					if LordSpawned() then return true end
					task.wait(0.3)
				end
				if LordSpawned() then return true end

				if FarmDucks() then return true end
			end
		end
		return LordSpawned()
	end

	local function PurpleCycle()
		local item = ITEM_INFO.PurpleKatana.name
		Status("Purple Katana: Checking bag")
		if ItemUnstore(item, 2) then return true end
		if not KeyActive("PurpleKatana") then return false end

		-- 1) หา Lord Sus
		if not LordSpawned() then
			Status("Purple Katana: Searching Lord Sus")
			StartMagnet = false
			pcall(TP, LORD_POS)
			task.wait(1.5)
			if not LordSpawned() then
				if not SummonLord() then return false end
			end
		end

		-- 2) รับเควส (ถ้าเควสไม่ขึ้นก็ยังสู้ต่อ)
		if not HasLordQuest() then TakeLordQuest() end

		-- 3) สู้จนตาย (ตายแล้วเควสยังอยู่ -> เสกใหม่)
		local abort = function() return ItemHave(item) end
		local guard = 0
		while KeyActive("PurpleKatana") and guard < 20 do
			guard = guard + 1
			if ItemHave(item) then break end
			WaitBusy()
			if IsDead() then
				task.wait(1)
			else
				local mob, hum, root = FindAlive(LORD)
				if mob then
					Status("Purple Katana: Fighting " .. LORD)
					FightOne("PurpleKatana", mob, hum, root, false, abort)
				elseif HasLordQuest() then
					if not SummonLord() then break end
				else
					break
				end
			end
		end
		if not KeyActive("PurpleKatana") then return false end

		-- 4) เช็ก/ถือ Purple Katana
		Status("Purple Katana: Checking bag")
		task.wait(1)
		return ItemUnstore(item, 3)
	end

	local CYCLES = { PinkHammer = PinkCycle, Banana = BananaCycle, PurpleKatana = PurpleCycle }

	-- ตัวเช็กไอเทมถี่ๆ (ทุก 0.2 วินาที): มีในกระเป๋า/ในมือเมื่อไหร่ = เสร็จทันที ทุกลูปในโหมดนี้หยุด แล้วไปทำอย่างอื่นต่อ
	task.spawn(function()
		while task.wait(0.2) do
			if CONFIG.AutoItemQuests then
				for key, info in pairs(ITEM_INFO) do
					if not _G.ItemDone[key] and ItemHave(info.name) then
						_G.ItemDone[key] = true
						SetDone(info.ui)
						StartMagnet = false
						print("[ItemQuest] ได้ " .. info.name .. " แล้ว -> หยุดทันที")
					end
				end
			end
		end
	end)

	-- ลูปหลัก
	task.spawn(function()
		local cycles = {}
		while task.wait(0.3) do
			if Active() then
				pcall(function()
					WaitBusy()
					if IsDead() then return end
					local key = _G.ItemQuestKey
					if not key or _G.ItemDone[key] or not CYCLES[key] then return end
					local n = (cycles[key] or 0) + 1
					local cap = CONFIG.ItemQuestMaxCycles or 0
					if cap > 0 and n > cap then
						_G.ItemDone[key] = true   -- ยอมแพ้ (ไม่ขึ้นไฟเขียว)
						warn("[ItemQuest] " .. key .. " ครบ " .. cap .. " รอบแล้วยังไม่ได้ หยุดอันนี้")
						return
					end
					print("[ItemQuest]", key, "รอบที่", n)
					if CYCLES[key]() then
						_G.ItemDone[key] = true
						SetDone(ITEM_INFO[key].ui)
						StartMagnet = false
						print("[ItemQuest] ได้ " .. ITEM_INFO[key].name .. " แล้ว")
					elseif KeyActive(key) then
						cycles[key] = n   -- นับเฉพาะรอบที่ทำจนจบ (ไม่ใช่ถูกโหมดอื่นแทรก)
					end
				end)
			end
		end
	end)

	-- ตัวคุมโหมด: เข้าเมื่อเข้าเงื่อนไข (ไม่แทรกกลางเรด) / ออกเมื่อไม่เข้าเงื่อนไขติดกัน 2 วินาที
	task.spawn(function()
		local offCount = 0
		while task.wait(1) do
			pcall(function()
				if not CONFIG.AutoItemQuests then return end
				-- มีไอเทมในกระเป๋าแล้ว (ได้มาด้วยวิธีอื่น) -> ถือว่าเสร็จ ไฟเขียวใน UI
				for key, info in pairs(ITEM_INFO) do
					if not _G.ItemDone[key] and ItemHave(info.name) then
						_G.ItemDone[key] = true
						SetDone(info.ui)
					end
				end

				local want = ItemQuestWanted()
				if want then
					offCount = 0
					if not _G.ItemQuest then
						if not _G.Raid and not RaidGuiVisible() then
							_G.ItemQuest = true
							_G.ItemQuestKey = want
							_G.FlameKatana = false
							_G.RaceV2 = false
							_G.EvilNoob = false
							_G.Pumpkin = false
							_G.AutoFarm = false
							StartMagnet = false
							print("[ItemQuest] เข้าโหมด Item Quest:", want)
						end
					elseif _G.ItemQuestKey ~= want then
						_G.ItemQuestKey = want   -- อันก่อนหน้าเสร็จแล้ว -> ไปอันถัดไป
						StartMagnet = false
						print("[ItemQuest] ไปทำอันถัดไป:", want)
					end
				else
					offCount = offCount + 1
					if _G.ItemQuest and offCount >= 2 then
						_G.ItemQuest = false
						_G.ItemQuestKey = nil
						_G.ItemQuestStatus = nil
						StartMagnet = false
						HoverOrigin = nil
						if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
						print("[ItemQuest] ออกจากโหมด Item Quest")
					end
				end
			end)
		end
	end)
end

-- ===================== Boss Watch (Meme Beast 1500+ / Giant Pumpkin 1100+ / Evil Noob 2000+ ถ้ายังไม่มี Yellow Blade) =====================
-- เช็กตลอด: บอสเกิด -> หยุดโหมดอื่นทั้งหมด วาร์ปไปฟาร์มทันที (Giant Pumpkin รับเควสก่อน) จบแล้วโหมดเดิมกลับมาเอง
-- ไม่แทรกตอนกำลังสู้ในเรด (RaidGui ขึ้นอยู่) / ช่วงโหมด Pumpkin เดิมทำงานอยู่ (เลเวล 1100-1199) ให้โหมดนั้นจัดการเอง
do
	local function Level()
		local ok, lv = pcall(function() return LocalPlayer.PlayerData.Level.Value end)
		return ok and lv or nil
	end

	-- เกิดแล้ว = มีมอนชื่อนี้ที่ Health > 0 (นับแบบเดียวกับรายงาน Enemy_Location: SpawnInfo) หรือเจอใน workspace.Monster
	-- คืน: เกิดไหม, ระยะใกล้สุดจากพาร์ตจุดเกิดใน workspace.Location.Enemy_Location
	local function Spawned(name)
		local count, nearest = SpawnInfo(name)
		return (count > 0 or FindAlive(name) ~= nil), nearest
	end

	-- Evil Noob (Yellow Blade): ยังไม่มีดาบ + บอสเกิดอยู่ -> true, ระยะ  (ใช้ทั้งตอนเลือกบอสและตอนแย่งจากฟักทอง)
	local function NoobBossReady()
		if not CONFIG.AutoBossWatch then return false end
		if DropX2Needed and DropX2Needed() then return false end   -- ยังไม่ซื้อ Drop X2 -> ไม่ไปตี Evil Noob
		local lv = Level()
		if not lv then return false end
		if CONFIG.AutoEvilNoob and not _G.EvilNoobDone and not _G.NoobRaidPhase and lv >= CONFIG.EvilNoobMinLevel then
			local c = LocalPlayer.Character
			local have = FindTool("Yellow Blade")
			if not have then
				local s, d = Spawned("Evil Noob")
				if s then return true, d end
			end
		end
		return false
	end

	-- ลำดับความสำคัญบอส: Meme Beast > Evil Noob > Giant Pumpkin (เกิดพร้อมกัน Noob มาก่อนฟักทอง)
	local function FindBoss()
		if not _G.XH_Auto or not CONFIG.AutoBossWatch then return end
		local lv = Level()
		if not lv then return end
		if lv >= CONFIG.MemeBeastMinLevel and not _G.Aura then
			local s, d = Spawned("Meme Beast")
			if s then return "Meme Beast", d end
		end
		local nb, nd = NoobBossReady()
		if nb then return "Evil Noob", nd end
		if lv >= CONFIG.GiantPumpkinWatchMinLevel and not _G.Pumpkin then
			local s, d = Spawned("Giant Pumpkin")
			if s then return "Giant Pumpkin", d end
		end
	end

	local NOOB_QUEST_POS = CFrame.new(2890.924561, -51.792477, 4207.233887)
	local function NoobQuest()
		_G.BossStatus = "Boss: Evil Noob Quest"
		local prompts = CollectPrompts(NOOB_QUEST_POS, 25)
		local tries = 0
		while _G.Boss and tries < 8 do
			WaitBusy()
			if IsDead() then return end
			local need = true
			pcall(function()
				local slot = LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1
				if slot.Visible then
					if string.find(string.lower(slot.Target.Text), "evil noob") then
						need = false
					else
						RS.OtherEvent.QuestEvents.Quest:FireServer("Abandon_Quest", { QuestSlot = "QuestSlot1" })
					end
				end
			end)
			if not need then break end
			tries = tries + 1
			TP(NOOB_QUEST_POS)
			task.wait(0.3)
			PressE()
			for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
			task.wait(0.5)
		end
	end

	-- ตอนเริ่ม: เช็กว่ามีพาร์ตจุดเกิดของมอนที่ใช้อยู่ใน Enemy_Location จริงไหม (ชื่อไม่ตรง = ตัวเช็กจะอาศัย workspace.Monster อย่างเดียว)
	task.spawn(function()
		task.wait(3)
		for _, n in ipairs({ "Meme Beast", "Giant Pumpkin", "Evil Noob", "Moai" }) do
			local cf = SpawnLocation(n)
			if cf then
				print(string.format("[Spawn] %s จุดเกิด (%.0f, %.0f, %.0f)", n, cf.X, cf.Y, cf.Z))
			else
				warn("[Spawn] ไม่พบพาร์ต '" .. n .. "' ใน workspace.Location.Enemy_Location")
			end
		end
	end)

	local function PumpkinQuest()
		_G.BossStatus = "Boss: Giant Pumpkin Quest"
		local prompts = CollectPrompts(PUMPKIN_QUEST_POS, 25)
		local tries = 0
		while _G.Boss and tries < 8 do
			WaitBusy()
			if IsDead() then return end
			local need = true
			pcall(function()
				local slot = LocalPlayer.PlayerGui.QuestGui.Holder.QuestSlot1
				if slot.Visible then
					if string.find(string.lower(slot.Target.Text), "pumpkin") then
						need = false
					else
						RS.OtherEvent.QuestEvents.Quest:FireServer("Abandon_Quest", { QuestSlot = "QuestSlot1" })
					end
				end
			end)
			if not need then break end
			tries = tries + 1
			TP(PUMPKIN_QUEST_POS)
			task.wait(0.3)
			PressE()
			for _, pr in ipairs(prompts) do pcall(fireproximityprompt, pr) end
			task.wait(0.5)
		end
	end

	local function RunBoss(name)
		_G.BossStatus = "Boss: " .. name
		StartMagnet = false
		-- รอให้โหมดอื่นปล่อยตัวละคร (ตัวคุมโหมดแต่ละอันจะออกเองภายในไม่กี่วินาที)
		local t0 = tick()
		while (_G.Raid or _G.RaceV2 or _G.FlameKatana or _G.EvilNoob or _G.ItemQuest or _G.Pumpkin or _G.Baller or _G.Aura or _G.HakiReroll) and tick() - t0 < 6 do
			task.wait(0.2)
		end
		if _G.Raid then return end   -- เรดยังไม่ยอมออก (เช่น เรดเริ่มแล้ว) -> ไม่แย่ง

		if name == "Giant Pumpkin" then PumpkinQuest() end
		if name == "Evil Noob" then NoobQuest() end

		print("[Boss] ไปฟาร์ม", name)
		_G.BossStatus = "Boss: " .. name
		local preempted = false
		while _G.Boss do
			WaitBusy()
			if IsDead() then break end
			local mob, hum, root = FindAlive(name)
			if not mob then break end
			repeat
				task.wait()
				WaitBusy()
				if IsDead() then break end
				-- กำลังตีฟักทองอยู่แล้ว Evil Noob เกิด -> ทิ้งฟักทองไปทำ Noob ก่อน
				if name == "Giant Pumpkin" and NoobBossReady() then
					preempted = true
					print("[Boss] Evil Noob เกิด -> ทิ้ง Giant Pumpkin ไปตี Evil Noob ก่อน")
					break
				end
				if CONFIG.RaidSmart then MaybeRetreat() end
				StartMagnet = false
				AttackStep(root)
			until not _G.Boss or not mob.Parent or hum.Health <= 0
			StartMagnet = false
			if preempted or IsDead() then break end
		end
	end

	task.spawn(function()
		while task.wait(0.5) do
			if not _G.Boss then
				local ok, name, dist = pcall(FindBoss)
				if ok and name and not RaidGuiVisible() and not IsDead() then
					_G.Boss = true
					_G.BossTarget = name
					_G.AutoFarm = false
					print("[Boss] พบ", name, dist and dist < math.huge and string.format("(ห่างจุดเกิด %.0f)", dist) or "", "-> หยุดทุกอย่างแล้วไปฟาร์ม")
					pcall(RunBoss, name)
					_G.Boss = false
					_G.BossTarget = nil
					_G.BossStatus = nil
					StartMagnet = false
					HoverOrigin = nil
					if FarmAllowed() then _G.AutoFarm = CONFIG.AutoFarm end
					task.wait(1)
				end
			end
		end
	end)
end

end -- __MemeSeaMain

do
	local attempts = 0
	while MY_GEN == _G.__MemeSeaGen and attempts < 5 do
		local ok, err = xpcall(__MemeSeaMain, debug.traceback)
		if ok then break end
		attempts = attempts + 1
		warn(string.format("[Recover] สคริปต์หลัก Error (รอบ %d/5) -> รันใหม่ใน 3 วิ\n%s", attempts, tostring(err)))
		for _, th in ipairs(_G.__MemeSeaThreads) do if _cancel then pcall(_cancel, th) end end
		_G.__MemeSeaThreads = {}
		_wait(3)
	end
end