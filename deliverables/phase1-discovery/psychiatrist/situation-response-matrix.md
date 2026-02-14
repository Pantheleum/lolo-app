# Situation-Response Matrix

**Document ID:** LOLO-PSY-002
**Author:** Dr. Elena Vasquez, Women's Psychology Consultant
**Version:** 1.0
**Date:** 2026-02-14
**Classification:** Core AI Decision Engine Reference -- All modules
**Companion Document:** LOLO-PSY-001 (Women's Emotional State Framework)

---

> **Purpose:** This matrix maps 55+ real-world relationship situations to psychologically-informed response approaches. It is the primary decision-making reference for LOLO's AI engine when generating messages, action cards, SOS responses, and escalation decisions. Every situation is cross-referenced with the Emotional State Framework (LOLO-PSY-001) for hormonal context, cultural calibration, and ethical compliance. No AI output should contradict the guidance contained in this document or its companion framework.

---

## Table of Contents

1. [Escalation Rules and Decision Logic](#escalation-rules-and-decision-logic)
2. [Menstrual Cycle Situations (S001-S008)](#category-1-menstrual-cycle-situations)
3. [Pregnancy Situations (S009-S017)](#category-2-pregnancy-situations)
4. [Postpartum Situations (S018-S023)](#category-3-postpartum-situations)
5. [Emotional Crisis Situations (S024-S035)](#category-4-emotional-crisis-situations)
6. [Daily Mood Situations (S036-S043)](#category-5-daily-mood-situations)
7. [Relationship Milestone Situations (S044-S049)](#category-6-relationship-milestone-situations)
8. [Family and Social Situations (S050-S055)](#category-7-family-and-social-situations)

---

# Escalation Rules and Decision Logic

## Severity Scale Definitions

| Level | Label | Description | AI Behavior |
|-------|-------|-------------|-------------|
| 1 | Mild | Normal daily fluctuation. She is slightly off but functioning well. | Light-touch suggestion. Standard action cards. Warm tone. |
| 2 | Moderate | Needs attention but not urgent. Sustained negative mood or emerging pattern. | Proactive care recommended. Increased check-in frequency. Comfort-oriented action cards. |
| 3 | Significant | Active emotional distress. Behavioral changes visible. Partner is concerned. | Focused support. De-escalation messaging. Gentle introduction of professional support suggestion. |
| 4 | Severe | Relationship-threatening or deep emotional pain. Functional impairment. | Careful, sustained response. Direct recommendation for professional support. Crisis resources accessible. |
| 5 | Crisis | Mental health risk. Safety concerns for her, the baby, or others. | Immediate crisis protocol. Emergency resources displayed. App disclaims therapeutic role. |

## Decision Tree: Space vs. Action

| Signal from Her | Recommend Space | Recommend Action | Notes |
|----------------|----------------|-----------------|-------|
| She explicitly says "Leave me alone" | Yes -- respect it fully | After the time she specified (or 30-60 min), return with a gentle check-in | Never punish her request for space with withdrawal or sulking |
| She is angry and escalating vocally | Yes -- brief (15-20 min cooling period) | After cooling: active listening, no defensiveness | He should say "I want to hear you. I'm going to give us both a few minutes, and I'll come back." |
| She is crying and reaching toward him | No | Immediate physical and emotional presence | This is a bid for connection. Rejection here causes lasting damage. |
| She is crying but turned away / silent | Partial -- be nearby but not intrusive | Sit in the same room. Quiet presence. Wait for her signal. | Say: "I'm right here whenever you're ready." |
| She is overwhelmed and snapping at everyone | Brief space, then return with tangible help | Take tasks off her plate without asking permission | Do not ask "What can I do?" -- just do something visible. |
| She said "I'm fine" but body language contradicts | Do not give space -- she is testing whether he will pursue | Gentle, persistent care: "You don't seem fine, and that's okay. I'm here." | The "I'm fine" test is one of the most common relationship dynamics. Walking away fails it. |
| She is withdrawn for more than 48 hours | No -- prolonged withdrawal may indicate depression | Gentle but direct: "I've noticed you've been quiet. I'm worried about you. Can we talk?" | If withdrawal exceeds 2 weeks, escalate to Level 3. |
| She is in acute distress (Level 4-5) | Never leave her alone unless she insists AND is safe | Continuous presence. Professional referral. | If she insists on being alone and there are safety concerns, contact a trusted person to be with her. |

## Decision Tree: Conversation vs. Gesture

| Situation Type | Lead with Conversation | Lead with Gesture | Notes |
|---------------|----------------------|-------------------|-------|
| She is processing emotions verbally | Yes -- listen actively | Follow up with a gesture after | She needs to be heard before she needs to be helped. |
| She is physically exhausted or in pain | No -- words can feel like more demands | Yes -- acts of service, physical comfort | Actions speak louder when she has no energy for words. |
| There has been a fight or betrayal | Yes -- but only when she is ready | Gesture first to signal safety, then conversation | A premature "let's talk" after betrayal feels like pressure. |
| She is celebrating or happy | Yes -- enthusiastic engagement | Yes -- both simultaneously | Match her energy with words AND actions. |
| She is grieving | Minimal words, maximum presence | Yes -- quiet gestures of care | "I'm here" + a warm blanket beats a 10-minute speech. |
| She is anxious about something specific | Yes -- calm, grounding conversation | Accompany with grounding gestures (hand-holding, tea) | Help her name and externalize the fear. |
| She feels taken for granted | Both -- but conversation must come first | Gesture without conversation feels like a bribe | She needs to hear "I see you and I'm sorry" before flowers mean anything. |

## Depression and Anxiety Flag Criteria

The AI must monitor for these patterns across all situations and escalate regardless of the originating situation:

**Flag for Depression Screening (Severity 3+):**
- Persistent sadness, emptiness, or emotional flatness lasting more than 2 weeks
- Loss of interest in activities she previously enjoyed
- Significant sleep changes (insomnia or hypersomnia) not explained by life circumstances
- Appetite changes (significant increase or decrease)
- Expressed feelings of worthlessness, excessive guilt, or self-blame
- Difficulty concentrating or making decisions
- Social withdrawal from friends, family, and partner
- Repeated statements of hopelessness about the future

**Flag for Anxiety Screening (Severity 3+):**
- Persistent, excessive worry that she cannot control
- Physical symptoms: racing heart, nausea, dizziness, muscle tension
- Avoidance of situations, people, or places due to fear
- Sleep disruption due to racing thoughts
- Checking behaviors or need for constant reassurance
- Difficulty being present -- always anticipating future problems
- Panic episodes (sudden onset of intense fear with physical symptoms)

**Flag for Immediate Crisis (Severity 5):**
- Any mention of self-harm or suicidal ideation
- Expressions of wanting to "disappear" or "not exist"
- Statements about being a burden to others
- In postpartum: thoughts of harming the baby or statements that the baby would be better off without her
- Hallucinations, delusions, severe confusion, or paranoia
- Erratic behavior that represents a sudden, dramatic personality change

**Crisis Resource Display Protocol:**
When Severity 5 is triggered, the app MUST:
1. Display the message: "This situation is beyond what LOLO can help with. Please reach out to a professional right away."
2. Show region-appropriate emergency numbers and crisis hotlines.
3. Provide a one-tap call button to crisis services.
4. Log the event for follow-up (with user consent per privacy policy).
5. Continue to provide supportive messaging to the partner about how to be present during a crisis.

---

# Category 1: Menstrual Cycle Situations

> **Cross-reference:** LOLO-PSY-001, Sections 1.1-1.4 (Menstrual Cycle Phases)

---

## S001: She Has Bad Cramps Today

| Field | Detail |
|-------|--------|
| **Situation ID** | S001 |
| **Category** | Menstrual |
| **Situation** | She is experiencing significant menstrual cramps. She may be in visible pain, moving slowly, holding her abdomen, or lying down. She may or may not have told him directly. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Physical pain is dominating her emotional bandwidth. She feels frustrated that her body is limiting her, possibly embarrassed if she has to cancel plans or underperform at work. Underneath the pain is a desire to be seen and cared for without having to ask. She may feel resentful if she has to explain or justify her pain. |
| **What He Thinks He Should Do** | Suggest she take a painkiller and push through. Or avoid the topic entirely because menstruation makes him uncomfortable. Or say "Sorry babe" once and move on with his day. |
| **What She Actually Needs** | Proactive physical comfort without her having to ask. Acknowledgment that her pain is real and valid. Reduced expectations for the day -- he should take over tasks she normally handles. Warmth (literal: heating pad, warm drink; and emotional: tenderness and patience). |
| **Recommended Message Tone** | Gentle, caring, low-pressure |
| **Sample Message** | "Hey, I know today's rough on you. I'm handling dinner tonight -- you just rest. Want me to bring you some tea and the heating pad?" |
| **Action Card Suggestion** | **DO:** Get the heating pad ready and bring her favorite warm drink without being asked. **BUY:** Pick up her preferred pain relief and a small comfort item (chocolate, her favorite snack). **SAY:** "Take it easy today. I've got everything covered." **GO:** No outings today -- create a cozy space at home for her. |
| **Escalation Trigger** | Pain is so severe she cannot function for multiple cycles (possible endometriosis or other condition) -- suggest she see a gynecologist. If he reports she is regularly missing work or school due to cramps, flag for medical follow-up. |
| **Cultural Variations** | **Western:** He can acknowledge her period directly. "I know you're on your period and in pain -- let me help." Direct, compassionate. **Arabic:** Do not reference her period explicitly. Observe her behavior (lying down, quieter than usual, holding abdomen) and respond with care: "You look tired today. Let me take care of things." Frame it as attentiveness, not cycle awareness. **Malay:** Moderate directness. He can say "Are you not feeling well?" without naming the cause. Traditional remedies (warm ginger drink / "air halia") may be appreciated. Respect any "pantang" practices she follows. |

---

## S002: PMS Mood Swings (Luteal Phase)

| Field | Detail |
|-------|--------|
| **Situation ID** | S002 |
| **Category** | Menstrual |
| **Situation** | She is in her late luteal phase (days 23-28). Her mood is shifting rapidly -- she may be tearful one moment, irritable the next, then seemingly fine. She may be picking fights over small things or withdrawing emotionally. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | She is experiencing genuine neurochemical mood instability due to progesterone and estrogen withdrawal. She likely knows her reactions feel disproportionate, which adds frustration and self-criticism on top of the original emotions. She feels out of control of her own mood, which is frightening. She may feel guilty for snapping at him. Underneath everything: she wants to be loved even when she is difficult to love. |
| **What He Thinks He Should Do** | Point out that she is PMSing. Argue back when she picks a fight. Withdraw and wait for it to pass. Tell her she is overreacting. Try to logic her out of her feelings. |
| **What She Actually Needs** | Unwavering patience and warmth. Zero attribution of her feelings to her cycle (even if he is thinking it). Validation that her feelings are real regardless of cause. Extra gentleness and forgiveness for sharp words. A partner who does not keep score during this window. |
| **Recommended Message Tone** | Warm, patient, validating |
| **Sample Message** | "I can tell today's been hard. I'm not going anywhere -- whatever you need, I'm here. No pressure to talk or explain." |
| **Action Card Suggestion** | **SAY:** "Your feelings are valid. I love you even on the hard days -- especially on the hard days." **DO:** Absorb her irritability without reacting. Do not escalate. Take something off her plate. **BUY:** Her comfort food. Do not comment on it. **GO:** Nowhere unless she wants to. Let her set the pace tonight. |
| **Escalation Trigger** | If mood disturbance is severe (rage episodes, inability to function, self-harm talk) and occurs every cycle, flag for possible PMDD. Suggest she discuss with her doctor. PMDD is a clinical condition requiring medical treatment. |
| **Cultural Variations** | **Western:** He may acknowledge the pattern gently: "I've noticed the last few days have been harder for you. What can I do?" Never say "PMS" as a label. **Arabic:** She may not connect her mood to her cycle openly. He should respond to the emotion, not the cause. Extra acts of service carry weight. If she is fasting during Ramadan and in her luteal phase, the combination intensifies symptoms significantly -- be especially attentive. **Malay:** She may practice "sabar" (patience/endurance) and suppress her mood shifts, leading to a delayed eruption. If she suddenly becomes very quiet or avoidant, he should gently check in rather than assuming all is well. |

---

## S003: She Is Irritable and Does Not Know Why

| Field | Detail |
|-------|--------|
| **Situation ID** | S003 |
| **Category** | Menstrual |
| **Situation** | She is snapping at him, finding fault with small things, or radiating frustration. When asked what is wrong, she says "I don't know" or "Nothing" -- and she genuinely may not know. This could be hormonal, stress-related, or a combination. |
| **Severity** | 1 (Mild) |
| **Her Likely Emotional State** | Confused by her own irritability. She may feel guilty for being short-tempered but unable to stop. There is often an undercurrent of sensory overload -- sounds, requests, and demands feel amplified. She wants fewer inputs and more space, but she also does not want to feel alone in her discomfort. |
| **What He Thinks He Should Do** | Demand an explanation. Take it personally. Argue that he has not done anything wrong. Withdraw in a huff. Dismiss it as "one of those days." |
| **What She Actually Needs** | Acceptance of the ambiguity. He does not need to diagnose her mood. Low-demand presence: be nearby, be warm, but do not poke or prod. Reduced household noise and demands. A partner who does not make her irritability about himself. |
| **Recommended Message Tone** | Calm, warm, undemanding |
| **Sample Message** | "You seem a bit off today, and that's okay. You don't need to explain it. I'm just going to make things easier for you tonight." |
| **Action Card Suggestion** | **SAY:** "You don't have to know why. I'm here either way." **DO:** Quietly handle dinner, tidy the house, reduce demands on her. **BUY:** Nothing specific -- avoid grand gestures that demand a reaction. **GO:** If she wants a quiet walk, join her. Otherwise, keep the evening low-key. |
| **Escalation Trigger** | If "unexplained irritability" becomes a persistent pattern (weeks, not days), flag for anxiety or depression screening. |
| **Cultural Variations** | **Western:** Direct check-in is appropriate: "Hey, you seem off. Want to talk about it or just want me to be chill tonight?" **Arabic:** Read her behavior rather than asking directly. Increase acts of service. She may express irritability through criticism of household matters -- do not take it as literal critique; address the emotion underneath. **Malay:** She may say "tak apa" (it's nothing) as a reflexive response. He should read this as "I don't want to burden you" rather than literal truth. Gentle persistence is appropriate: "I can see something is bothering you. I'm here if you want to share." |

---

## S004: Heavy Flow Day -- She Is Exhausted

| Field | Detail |
|-------|--------|
| **Situation ID** | S004 |
| **Category** | Menstrual |
| **Situation** | She is on a heavy flow day (typically days 1-2 of menstruation). She is physically drained, may be pale, has low energy, and may be dealing with clotting, leaking anxiety, and the logistical burden of managing a heavy period while functioning in daily life. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Physical exhaustion dominates. She may feel embarrassed about the messiness of heavy flow. There is often quiet resentment that this is something she must endure monthly while life continues to demand full performance. She feels vulnerable and wants comfort without having to articulate the full scope of what she is managing. |
| **What He Thinks He Should Do** | Not notice or not mention it. Expect her to perform normally. Be visibly uncomfortable if she mentions blood or flow. Suggest she "rest up" as a throwaway comment without actually facilitating rest. |
| **What She Actually Needs** | Complete removal of non-essential tasks. Physical comfort: warm drinks, heating pad, comfortable clothing, clean bedding. Zero disgust or discomfort from him about the physical reality of menstruation. Active household management by him for the day. Permission to cancel plans without guilt. |
| **Recommended Message Tone** | Gentle, nurturing, practical |
| **Sample Message** | "Today's a rest day for you. I've already started on dinner, and the house is handled. What sounds good to you -- movie on the couch or early bed?" |
| **Action Card Suggestion** | **DO:** Take over all household duties for the day. Change the sheets if needed without comment. Have pain relief accessible. **BUY:** Iron-rich snacks (dark chocolate, nuts), her favorite comfort meal, fresh pads or tampons if running low. **SAY:** "You're dealing with a lot. Just rest -- I've got this." **GO:** Stay in. Create a nest for her on the couch or bed. |
| **Escalation Trigger** | If heavy flow is causing her to regularly miss work, experience dizziness or fainting, or if she reports soaking through products rapidly -- suggest she see her gynecologist. Possible menorrhagia or fibroids. |
| **Cultural Variations** | **Western:** He can be matter-of-fact about menstruation. Picking up pads at the store should be normalized. **Arabic:** Extreme discretion required. He should not reference the period directly. Prepare comfort measures silently. If she is not fasting or praying (indicators in an Islamic household), he simply provides extra care without commenting on why. **Malay:** He can offer "jamu" (traditional herbal tonic) or warm ginger water. Traditional confinement-style care (warmth, rest, specific foods) may be appreciated. Avoid drawing attention to the situation in front of extended family. |

---

## S005: She Is Bloated and Feels Unattractive

| Field | Detail |
|-------|--------|
| **Situation ID** | S005 |
| **Category** | Menstrual |
| **Situation** | She is in her late luteal or menstruation phase. Water retention has caused visible bloating. Her clothes feel tight. She may be standing in front of the mirror criticizing herself, refusing to get dressed for an event, or making negative comments about her body. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Deeply self-critical. She is filtering her entire self-worth through her physical appearance in this moment. She feels betrayed by her body. If there is an event or social obligation, anxiety about being seen compounds the distress. She wants to hear she is attractive but may not believe it. She is testing whether he still desires her in this state. |
| **What He Thinks He Should Do** | Say "You look fine." Dismiss her concern as superficial. Tell her she is being ridiculous. Ignore it and hope it passes. Or worse: agree and suggest she work out. |
| **What She Actually Needs** | Specific, genuine compliments that are not about her size. Reassurance of his desire and attraction that feels authentic, not obligatory. Normalization: "Bodies change day to day. You're beautiful to me every version." Zero comments about her eating, her weight, or her clothes being tight. If there is an event: help her find something she feels good in, or offer to cancel without resentment. |
| **Recommended Message Tone** | Warm, affirming, specific |
| **Sample Message** | "I heard you being hard on yourself this morning. I want you to know -- I think you're gorgeous. Not in spite of anything. Just... you. Always." |
| **Action Card Suggestion** | **SAY:** Give a specific, non-size-related compliment: "Your eyes are stunning today" or "I love the way you smell" or "You have the most beautiful smile." **DO:** If she is stressed about getting dressed, offer to help -- "Want me to help pick something? You look amazing in that blue dress." **BUY:** Nothing weight-related. A small item that makes her feel pampered: a nice body lotion, a scented candle. **GO:** If she wants to skip the event, support it. If she wants to go, be her biggest supporter. |
| **Escalation Trigger** | If body image distress is persistent (not just cycle-linked), extreme (refusing to eat, refusing to leave the house, self-harm talk), or accompanied by disordered eating behaviors -- flag for body dysmorphia or eating disorder screening. Severity 3-4. |
| **Cultural Variations** | **Western:** He can address it directly: "I can see you're feeling bad about your body today. I want you to know I find you beautiful." Body positivity language is culturally available. **Arabic:** Compliments about beauty carry deep significance. He should affirm her beauty in terms that resonate culturally -- elegance, grace, her eyes, her presence. Avoid Western body-positive language that may not translate. Physical appearance before family gatherings carries extra social weight. **Malay:** Similar to Arabic -- elegance and grace-based compliments land better than "you look hot." If she is comparing herself to others on social media, gently redirect: "You're the only one I see." |

---

## S006: She Wants Physical Intimacy but He Assumes She Does Not (Menstruation)

| Field | Detail |
|-------|--------|
| **Situation ID** | S006 |
| **Category** | Menstrual |
| **Situation** | She is on her period but is initiating physical closeness or giving signals of wanting intimacy (not necessarily sexual -- could be cuddling, kissing, or physical affection). He is pulling away because he assumes she does not want to be touched, or because menstruation makes him uncomfortable. |
| **Severity** | 1 (Mild) |
| **Her Likely Emotional State** | She wants connection and closeness. She may be feeling emotionally tender and craving the reassurance of physical touch. If he pulls away, she interprets it as rejection or disgust, which is deeply hurtful. She may feel that her period makes her "untouchable" in his eyes. |
| **What He Thinks He Should Do** | Give her space because she is on her period. Avoid physical contact. Wait until her period is over to re-engage physically. |
| **What She Actually Needs** | Responsive physical affection that follows her lead. If she initiates cuddling, he cuddles. If she wants to be held, he holds her. The signal is hers to give; his job is to receive it without hesitation or visible discomfort. Menstruation does not make her untouchable. |
| **Recommended Message Tone** | Warm, affectionate, natural |
| **Sample Message** | "Come here. I just want to hold you tonight." |
| **Action Card Suggestion** | **SAY:** "I always want to be close to you." **DO:** Follow her physical cues. If she is leaning in, lean in too. Initiate non-sexual touch: stroke her hair, hold her hand, rub her feet. **BUY:** Not applicable. **GO:** Stay in together. Physical closeness at home. |
| **Escalation Trigger** | None for this situation specifically. However, if she consistently feels rejected physically, it may erode sexual confidence and relationship satisfaction over time -- monitor for patterns. |
| **Cultural Variations** | **Western:** Physical and sexual intimacy during menstruation is increasingly normalized. Follow her lead. **Arabic:** Islamic guidelines prohibit sexual intercourse during menstruation, but physical affection (holding, cuddling, kissing) is permissible and encouraged. He should be warm and affectionate within these boundaries. **Malay:** Similar to Arabic context. Physical closeness and affection are welcome; sexual intercourse is typically avoided per Islamic practice. He should not treat her as "impure" -- this is a harmful misinterpretation of religious guidance. |

---

## S007: She Is Craving Comfort Food and Feels Guilty About It

| Field | Detail |
|-------|--------|
| **Situation ID** | S007 |
| **Category** | Menstrual |
| **Situation** | She is in her luteal or menstruation phase and craving carbohydrates, chocolate, or comfort food. She may be eating more than usual and making self-deprecating comments about it ("I'm such a pig," "I'm going to get fat," "I have no willpower"). |
| **Severity** | 1 (Mild) |
| **Her Likely Emotional State** | Her serotonin levels are depleted, creating a genuine biological drive for carbohydrates and sugar. She knows this intellectually but still feels guilty because diet culture has taught her that eating for comfort is a moral failing. She is battling her own body's needs against internalized shame. If he comments on her eating, the shame intensifies dramatically. |
| **What He Thinks He Should Do** | Make a joke about her eating. Suggest healthier alternatives. Comment on the amount she is eating. Say nothing but give a look. Or join her in eating but frame it as "cheating" together. |
| **What She Actually Needs** | Complete absence of judgment about what or how much she eats. Ideally, he proactively brings her the comfort food she craves. If she makes self-deprecating comments, gently counter them without making it a lecture. Normalization: her cravings are biologically driven and legitimate. |
| **Recommended Message Tone** | Light, warm, normalizing |
| **Sample Message** | "I'm stopping by the store. Want me to grab that chocolate you like? Don't even think about saying no -- you deserve it." |
| **Action Card Suggestion** | **SAY:** "Enjoy it. Your body knows what it needs." **DO:** Bring her the craving food without her asking. Do not comment on portions. **BUY:** Her specific comfort food -- know her favorites. Chocolate, ice cream, salty snacks, whatever she gravitates toward. **GO:** If she wants to go out for food, make it fun -- not a guilty pleasure, just a pleasure. |
| **Escalation Trigger** | If guilt about eating becomes extreme, if she is binge-eating and purging, or if food-related distress is persistent beyond the luteal/menstrual window -- flag for disordered eating screening. Severity 3-4. |
| **Cultural Variations** | **Western:** He can be playful: "I brought supplies for tonight -- chocolate, popcorn, and zero judgment." Diet culture is pervasive in Western contexts, so his non-judgmental attitude is especially healing. **Arabic:** Food is central to care in Arabic culture. Preparing or bringing her favorite foods is a powerful act of love. He should never comment on her weight or eating habits. **Malay:** Traditional comfort foods (warm soups, herbal drinks) are culturally appropriate to offer. "Makan" (eating together) is a bonding activity. He can prepare something warm for her as an act of care. |

---

## S008: She Snaps at Him and Then Feels Terrible About It

| Field | Detail |
|-------|--------|
| **Situation ID** | S008 |
| **Category** | Menstrual |
| **Situation** | She said something sharp, critical, or hurtful to him during her luteal or menstruation phase. Almost immediately or shortly after, she feels horrible about it. She may apologize profusely, cry, or withdraw in shame. The cycle of snap-guilt-shame can repeat multiple times. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Caught in a loop of reduced impulse control (hormonal) and intense self-judgment. She heard herself say the words and winced internally. She is afraid he will hold it against her, accumulate resentment, or use it as evidence that she is "difficult." The guilt compounds the existing hormonal distress. She needs forgiveness more than she needs a conversation about what she said. |
| **What He Thinks He Should Do** | Get angry back. Keep score ("You always do this"). Demand an apology and an explanation. Withdraw silently, making her feel worse. Use it as ammunition in a future argument. |
| **What She Actually Needs** | Quick, genuine forgiveness. A short-memory approach: "It's okay. I know you didn't mean it. We're good." Reassurance that one sharp moment does not define the relationship. Zero score-keeping. Physical affection to signal that the rupture is repaired. |
| **Recommended Message Tone** | Forgiving, steady, reassuring |
| **Sample Message** | "Hey -- we're okay. I know that wasn't really you. I love you, and one rough moment doesn't change anything." |
| **Action Card Suggestion** | **SAY:** "Already forgotten. Come here." **DO:** Initiate a hug or physical reassurance immediately after the snap. Do not dwell on the content of what she said. **BUY:** Not applicable. **GO:** Move the evening forward naturally. Do not freeze the atmosphere. |
| **Escalation Trigger** | If she is verbally abusive (not just sharp but consistently cruel, demeaning, or threatening), this is not a hormonal situation -- it is a relationship dynamic that may require couples counseling. The AI must not excuse genuine emotional abuse by attributing it to hormones. |
| **Cultural Variations** | **Western:** He can name it directly: "I know you're having a tough day. That stung a bit, but I'm not holding it against you. We're good." **Arabic:** Forgiveness is a deeply valued Islamic principle. He can frame it through that lens: "It's nothing. We all have difficult days." Maintaining household harmony is important -- he should repair quickly rather than allowing tension to linger. **Malay:** "Sabar" (patience) is culturally prized. He demonstrates it by absorbing the moment gracefully. She will respect his patience and feel safe that he does not escalate. A quiet, warm gesture afterward (making her tea, sitting beside her) signals repair. |

---

# Category 2: Pregnancy Situations

> **Cross-reference:** LOLO-PSY-001, Sections 2.1-2.3 (Pregnancy by Trimester)

---

## S009: Morning Sickness Is Debilitating

| Field | Detail |
|-------|--------|
| **Situation ID** | S009 |
| **Category** | Pregnancy |
| **Situation** | She is in her first trimester and experiencing severe nausea and vomiting. It may not be limited to mornings -- many women experience all-day sickness. She may be unable to eat, unable to work, and barely able to function. She may be suffering in silence because she has not announced the pregnancy yet. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Miserable, trapped, and possibly questioning whether she can endure this for weeks more. She may feel guilty for not being "happy enough" about the pregnancy because she feels so physically terrible. She is exhausted from vomiting and from pretending everything is fine in public. She may fear the nausea means something is wrong, or paradoxically fear that if it stops, something is wrong. |
| **What He Thinks He Should Do** | Say "At least it means the baby is healthy." Suggest ginger ale or crackers as if she has not already tried everything. Express frustration that she cannot do her usual tasks. Minimize it because "it's normal." |
| **What She Actually Needs** | Total household takeover during the worst days. Management of food smells (cook away from her, ventilate the kitchen, avoid triggering foods). Small, frequent offerings of whatever she can tolerate -- without frustration when she rejects them. Emotional validation: "This is brutal and I'm sorry you're going through it." Willingness to hold her hair, clean the bathroom, and never show disgust. |
| **Recommended Message Tone** | Deeply compassionate, practical |
| **Sample Message** | "I know this is so much harder than anyone talks about. You're doing something incredible, and I'm going to make sure you don't have to worry about anything else. What sounds tolerable for dinner? Even if it's just crackers, I'll make it happen." |
| **Action Card Suggestion** | **DO:** Take over all cooking and cleaning. Keep the house ventilated. Have her preferred tolerable foods always stocked. **BUY:** Ginger candies, sparkling water, bland crackers, whatever she has identified as tolerable. A wristband for nausea (Sea-Bands). **SAY:** "You're growing a human. That's the hardest job there is. I've got everything else." **GO:** No restaurants unless she specifically wants to go. Smells are triggers. |
| **Escalation Trigger** | If she cannot keep any food or water down for 24+ hours, is losing weight rapidly, or shows signs of dehydration (dark urine, dizziness, fainting) -- this may be hyperemesis gravidarum and requires medical attention. Do not manage this at home. Severity 4. |
| **Cultural Variations** | **Western:** He can be hands-on and vocal about supporting her through sickness. Prenatal care is primarily medical. **Arabic:** Female relatives (especially her mother) often provide primary physical care during pregnancy sickness. He should support by ensuring she has access to this family support, managing household logistics, and being emotionally present without needing to be the hands-on caretaker if cultural norms dictate otherwise. **Malay:** Traditional remedies for morning sickness ("air asam," sour drinks, certain herbal preparations) may be preferred alongside medical treatment. He should support both. The "bidan" (traditional midwife) may offer advice -- respect this alongside medical guidance. |

---

## S010: Pregnancy Anxiety -- Is the Baby Okay?

| Field | Detail |
|-------|--------|
| **Situation ID** | S010 |
| **Category** | Pregnancy |
| **Situation** | She is consumed by worry about the baby's health. This may be triggered by a symptom (bleeding, cramping, reduced movement), a concerning test result, or simply the ambient anxiety of first-trimester miscarriage risk. She may be obsessively Googling symptoms or counting kicks. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Terrified. The love she already feels for the baby makes the fear of losing it almost unbearable. She may be catastrophizing (imagining the worst), bargaining (superstitious behaviors to "keep the baby safe"), or emotionally numbing to protect herself from potential loss. She feels alone in the intensity of this fear -- no one else seems to worry as much as she does. |
| **What He Thinks He Should Do** | Reassure her with statistics ("The chances are really low"). Tell her to stop Googling. Dismiss the worry as excessive. Express annoyance at her anxiety. |
| **What She Actually Needs** | Validation that her fear makes sense: "Of course you're scared. You love this baby already." A partner who shares the emotional weight of the uncertainty rather than dismissing it. Practical support: "Let's call the doctor and just check. There's no harm in asking." His own emotional engagement with the pregnancy -- she needs to know he cares as deeply as she does. |
| **Recommended Message Tone** | Steady, grounding, emotionally present |
| **Sample Message** | "I know how scared you are, and I am too. This baby is so loved already, and that's exactly why this feels so big. If you want, let's call the doctor together just to hear that everything's on track. I'm right here with you." |
| **Action Card Suggestion** | **SAY:** "Your worry means you're already an amazing mom. Let's get reassurance together." **DO:** Offer to call the doctor or midwife for her. Attend every appointment possible. Put your hand on her belly and be present. **BUY:** A pregnancy journal where she can track feelings and milestones -- gives anxiety a constructive outlet. **GO:** To the doctor together if she needs reassurance. Never make her feel it is an overreaction to seek medical confirmation. |
| **Escalation Trigger** | If anxiety is so severe she cannot sleep, eat, or function. If she develops obsessive checking behaviors that interfere with daily life. If there is an actual medical concern (bleeding, pain, reduced fetal movement) -- immediate medical attention, not app management. Severity 4-5 for medical symptoms. |
| **Cultural Variations** | **Western:** Open discussion of pregnancy anxiety is increasingly normalized. He can say "I'm worried too" without cultural friction. Prenatal testing and medical reassurance-seeking are standard. **Arabic:** Pregnancy is often kept private in the first trimester to avoid the "evil eye" (envy). Her anxiety may be compounded by the pressure to keep the pregnancy secret. Islamic prayers for protection (du'a) may be a meaningful source of comfort. He can suggest they pray together for the baby's safety. **Malay:** Traditional spiritual protections (prayers, amulets, specific surahs from the Quran) may be part of her anxiety management. He should participate in these practices if they are meaningful to her. The bidan may offer reassurance through traditional methods -- this is valid alongside medical care. |

---

## S011: Body Image Changes During Pregnancy

| Field | Detail |
|-------|--------|
| **Situation ID** | S011 |
| **Category** | Pregnancy |
| **Situation** | Her body is changing visibly -- weight gain, stretch marks, swollen feet, breast changes, skin changes. She may be struggling with her reflection, avoiding mirrors, or making negative comments about how she looks. She may feel she has lost her identity and become "just a vessel." |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Conflicted. She may understand intellectually that her body is doing something extraordinary, but emotionally she grieves her pre-pregnancy body. She fears her partner no longer finds her attractive. She may feel that society only celebrates the "cute bump" stage and is unprepared for the reality of swelling, weight distribution, and skin changes. She is watching herself transform and feels she has no control. |
| **What He Thinks He Should Do** | Say "You're glowing!" (generic). Avoid the topic entirely. Make a joke about her size. Reassure with "You'll lose the weight after." Focus on the baby rather than her. |
| **What She Actually Needs** | Specific, repeated, genuine expressions of desire and attraction. Not "You're beautiful for a pregnant woman" but "You are beautiful. Period." Physical affection that confirms his attraction -- initiating closeness, complimenting her body with desire (not just appreciation), looking at her the way he did before pregnancy. Reassurance that he sees HER, not just the pregnancy. |
| **Recommended Message Tone** | Intimate, affirming, desire-expressing |
| **Sample Message** | "I caught myself staring at you today. I know your body is changing, and I want you to know -- I have never been more attracted to you. You carrying our child is the most beautiful thing I have ever seen." |
| **Action Card Suggestion** | **SAY:** "You are stunning. Not 'for a pregnant woman.' Just stunning." Be specific -- compliment the curve of her belly, the softness of her skin, her strength. **DO:** Initiate physical affection. Touch her belly with reverence. Look at her with visible desire. **BUY:** Something that makes her feel beautiful -- a soft robe, a pregnancy massage gift certificate, her favorite body oil. **GO:** On a date where she can dress up and feel like herself, not just "the pregnant one." |
| **Escalation Trigger** | If body image distress becomes severe: refusing to eat, extreme exercise during pregnancy, self-harm talk, or symptoms of prenatal depression. Severity 3-4. Medical attention needed. |
| **Cultural Variations** | **Western:** "Bump culture" on social media creates unrealistic pregnancy body standards. She may compare herself to influencers. He should actively counter this. **Arabic:** Pregnancy is celebrated and the pregnant body is culturally honored. However, weight-related comments from family members are common and can be hurtful. He should be her shield against unsolicited body commentary from relatives. **Malay:** Similar to Arabic -- pregnancy is celebrated but body commentary from elder women is common. He should affirm her consistently and privately. |

---

## S012: Nesting Phase Excitement

| Field | Detail |
|-------|--------|
| **Situation ID** | S012 |
| **Category** | Pregnancy |
| **Situation** | She is in a flurry of preparation -- organizing the nursery, washing baby clothes, researching products, creating lists, deep cleaning the house. She is highly focused, energized, and may seem obsessive about details (the exact shade of paint, the specific brand of bottle). |
| **Severity** | 1 (Mild) |
| **Her Likely Emotional State** | Energized, purposeful, and joyful -- but also channeling anxiety into productivity. Nesting is partly excitement and partly a coping mechanism for the loss of control that comes with impending birth. She wants her partner to share this energy and be an active participant, not a reluctant bystander. If he is dismissive or disengaged, she interprets it as not caring about the baby. |
| **What He Thinks He Should Do** | Tell her she is overdoing it. Point out they do not need half of what she is buying. Be passive and wait for instructions. Complain about the mess of reorganization. |
| **What She Actually Needs** | Active, enthusiastic participation. He should build the crib, paint the room, assemble the stroller -- not because she asked, but because he is excited too. Respect for her vision: if she wants a specific nursery theme, honor it. Shared decision-making that signals investment in parenthood. Energy-matching: meet her enthusiasm with his own. |
| **Recommended Message Tone** | Enthusiastic, collaborative, future-oriented |
| **Sample Message** | "I saw you organizing the nursery and it made me so happy. What's next on the list? I want to help. I'm getting excited about this little person too." |
| **Action Card Suggestion** | **SAY:** "This is going to be amazing. Our baby is so lucky to have you." **DO:** Build or assemble something for the nursery today. Research a baby item she mentioned and surprise her with a thoughtful choice. **BUY:** A nursery item she has been eyeing. A book of baby names to browse together. **GO:** To the baby store together -- make it a date, not a chore. |
| **Escalation Trigger** | If nesting becomes compulsive (she cannot rest, is cleaning at 3 AM, is spending beyond means, becomes distraught if something is not "perfect") -- this may be anxiety channeled through nesting. Gently redirect and monitor. Severity 2-3 if accompanied by inability to sleep or escalating distress. |
| **Cultural Variations** | **Western:** Nursery preparation is a major cultural ritual. Baby showers, registries, and themed nurseries are the norm. He is expected to participate visibly. **Arabic:** Family often participates in preparation. Her mother or mother-in-law may take a leading role. He should coordinate with family to support her vision rather than competing with family involvement. **Malay:** Communal preparation is common. The extended family may contribute items and advice. Traditional preparation rituals may occur alongside modern nursery setup. He should participate in both. |

---

## S013: Third Trimester Discomfort and Exhaustion

| Field | Detail |
|-------|--------|
| **Situation ID** | S013 |
| **Category** | Pregnancy |
| **Situation** | She is in weeks 30-40+. She cannot sleep because no position is comfortable. Her back hurts, her feet are swollen, she has to urinate constantly, she may have heartburn, pelvic pain, and shortness of breath. She is physically miserable and emotionally on edge as the due date approaches. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Exhausted, frustrated with her body, increasingly anxious about labor. She may feel trapped -- she wants the pregnancy to be over but is terrified of what comes next. She is emotionally volatile because hormones are at their lifetime peak and sleep deprivation is setting in. She may cry over seemingly small things because her emotional reserves are depleted. She wants recognition that what she is enduring is extraordinary. |
| **What He Thinks He Should Do** | Remind her it is almost over. Suggest she sleep on her side (as if she has not tried). Get frustrated when she cannot get comfortable. Continue his own normal routine while she struggles. |
| **What She Actually Needs** | Maximum practical support. He should be anticipating needs before she voices them. Pillow adjustment at night. Foot rubs without being asked. Taking over all bending, lifting, and physical tasks. Emotional patience: her tears and frustration are not directed at him. Verbal recognition: "What you're going through is incredible and I see it." Reliability: she needs to know she can reach him at all times as birth approaches. |
| **Recommended Message Tone** | Supportive, admiring, reliable |
| **Sample Message** | "I watched you try to get comfortable last night, and I want you to know -- I see how much your body is going through. You are the strongest person I know. What can I do to make tonight better?" |
| **Action Card Suggestion** | **SAY:** "You're almost there, and you're incredible. I'm in awe of you." **DO:** Offer a nightly foot or back rub. Take over all physical household tasks. Keep your phone charged and nearby at all times. **BUY:** A pregnancy pillow if she does not have one. Comfortable slippers for swollen feet. Her preferred antacid. **GO:** A gentle walk together if she is up for it -- movement can relieve some discomfort. Short, local outings only. |
| **Escalation Trigger** | If she develops sudden severe headache, vision changes, severe swelling (especially face/hands), or upper abdominal pain -- these may be signs of preeclampsia. Immediate medical attention. Severity 5. The app must NOT manage this. |
| **Cultural Variations** | **Western:** He is expected to be an active physical support during late pregnancy. Prenatal massage, birth classes, and hospital tours are standard couple activities. **Arabic:** Female family members often increase their presence in the final weeks. He should ensure she has the support network she wants and complement it with his own care. **Malay:** "Melenggang perut" (belly blessing ceremony) may occur around month 7. Traditional preparations intensify. He should participate meaningfully in both traditional and modern preparations. |

---

## S014: Birth Plan Stress

| Field | Detail |
|-------|--------|
| **Situation ID** | S014 |
| **Category** | Pregnancy |
| **Situation** | She is trying to plan for labor and delivery -- making decisions about pain management, birthing positions, who will be in the room, what happens if there are complications. She may feel overwhelmed by the options, pressured by conflicting advice, and anxious about making the "right" choice. She may feel judged for wanting an epidural or for wanting a natural birth. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Overwhelmed by the magnitude of the decisions and the stakes involved. She is trying to maintain control over an inherently uncontrollable event. She may feel pressure from family, friends, online communities, or her own idealism. If her partner is disengaged from birth planning, she feels abandoned -- he is supposed to be her birth partner, and he does not even know her preferences. |
| **What He Thinks He Should Do** | Defer entirely: "Whatever you want." Express opinions about pain management without understanding the full picture. Avoid discussing it because it stresses him out too. Make jokes about fainting in the delivery room. |
| **What She Actually Needs** | An engaged, informed birth partner. He should read the birth plan, attend the classes, and know her preferences without her having to quiz him. Active participation in discussions: "I've been reading about this -- here are my thoughts, but it's ultimately your body and your choice." Reassurance that he will advocate for her wishes in the delivery room if she cannot speak for herself. |
| **Recommended Message Tone** | Collaborative, reassuring, engaged |
| **Sample Message** | "I've been reading about the options you mentioned. I want to make sure I understand exactly what you want so I can be your voice if you need me to. Can we go through the plan together this weekend?" |
| **Action Card Suggestion** | **SAY:** "I'll be there every second, and I'll fight for what you want. You can count on me." **DO:** Read the birth plan. Attend birthing classes. Know the hospital route. Pack the hospital bag together. **BUY:** A birth plan template if she does not have one. A book on birth support for partners. **GO:** To the hospital tour, the birthing class, and every prenatal appointment you can attend. |
| **Escalation Trigger** | If birth plan stress escalates to paralyzing anxiety, panic attacks, or severe insomnia -- flag for prenatal anxiety. If she expresses fear of dying during childbirth, take it seriously and suggest she discuss it with her OB and a therapist. Severity 3. |
| **Cultural Variations** | **Western:** Birth planning is detailed and partner-centered. He is expected to be a primary support person during labor. Doula support is common. **Arabic:** The woman's mother or a female relative may be the primary birth companion. He may or may not be in the delivery room depending on family tradition and hospital policy. He should ask HER what she wants, not assume. **Malay:** A mix of traditional (bidan) and modern (hospital) birth preparation. He should support her chosen approach without imposing. |

---

## S015: She Feels He Is Not Excited Enough About the Pregnancy

| Field | Detail |
|-------|--------|
| **Situation ID** | S015 |
| **Category** | Pregnancy |
| **Situation** | She feels that he is going through the motions but not truly emotionally engaged with the pregnancy. He does not talk to the belly, does not bring up baby names spontaneously, does not seem to read the baby books, and shows little proactive excitement. She interprets his emotional restraint as indifference. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Lonely in the pregnancy. She is carrying the full emotional and physical weight and feels he is a spectator rather than a partner. She may question whether he wanted this baby, whether he will be a good father, and whether she can depend on him. This is not about him buying things or attending appointments -- it is about emotional engagement. She needs to FEEL his excitement. |
| **What He Thinks He Should Do** | Tell her he IS excited (without showing it). Perform excitement on command. Feel criticized and withdraw. Assume that because he has not said anything negative, she should know he is happy. |
| **What She Actually Needs** | Visible, unprompted emotional investment. Talk to the belly. Bring up names he likes. Share an article he read about fatherhood. Put his hand on her belly when the baby kicks and marvel at it. Cry a little at the ultrasound. Show her that this baby is real to him emotionally, not just logistically. |
| **Recommended Message Tone** | Emotionally open, vulnerable, father-to-be |
| **Sample Message** | "I was thinking about our baby today and I got emotional. I cannot wait to meet this little person. I want you to know -- I am so deeply in this with you. Sometimes I don't show it enough, and I'm going to do better." |
| **Action Card Suggestion** | **SAY:** "I was thinking about what kind of dad I want to be. Can I tell you?" **DO:** Talk to the baby. Put your hand on her belly and say something to your child. Research something baby-related and share it excitedly. **BUY:** A children's book "from Dad." A onesie with something meaningful printed on it. **GO:** To a baby-related outing of your choosing -- show initiative, not just compliance. |
| **Escalation Trigger** | If his emotional disengagement persists despite her expressed need, this becomes a relationship satisfaction issue that may require couples counseling. If she begins to withdraw emotionally in response, the disconnection can deepen postpartum. Severity 3-4. |
| **Cultural Variations** | **Western:** Emotional expressiveness from fathers is increasingly expected and celebrated. "Involved dad" is a strong cultural ideal. **Arabic:** Male emotional expressiveness about babies may be more reserved publicly but should be present privately. He can show excitement through actions (preparing the home, providing for her comfort) and through private emotional moments together. **Malay:** Family-oriented emotional expression is valued. He can show excitement by involving family, participating in traditional preparations, and expressing gratitude to Allah for the blessing. |

---

## S016: She Is Terrified of Labor and Delivery

| Field | Detail |
|-------|--------|
| **Situation ID** | S016 |
| **Category** | Pregnancy |
| **Situation** | As the due date approaches, her fear of labor intensifies. She may have heard traumatic birth stories, watched alarming videos, or have a pre-existing fear of medical procedures or pain. She may be having nightmares, avoiding birth preparation, or oscillating between hypervigilant preparation and avoidance. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Raw fear. She is facing an event that involves extreme physical pain, loss of bodily control, potential medical interventions, and a real (though statistically small) risk of serious complications. She may feel that no one takes her fear seriously because "women have been doing this forever." She may feel weak for being afraid. She needs her fear validated, not dismissed. |
| **What He Thinks He Should Do** | Say "Women have been doing this for thousands of years." Share positive birth statistics. Tell her not to worry. Change the subject because her fear makes him uncomfortable. |
| **What She Actually Needs** | Validation: "Of course you're scared. This is a huge thing." His own vulnerability: "I'm scared too. But I know you can do this, and I'll be right there." Practical reassurance: knowing he has prepared (hospital bag, route, birth plan memorized). Emotional commitment: "Whatever happens in that room, I will not leave your side." If the fear is severe (tokophobia), gentle encouragement to discuss with her OB or a therapist. |
| **Recommended Message Tone** | Steady, brave, deeply present |
| **Sample Message** | "I know you're scared. I'd be lying if I said I wasn't too. But here's what I know for certain: you are stronger than you realize, and I will be holding your hand through every single second of it. We're doing this together." |
| **Action Card Suggestion** | **SAY:** "You are going to be amazing. And I will be right there, not going anywhere." **DO:** Be visibly prepared. Know the birth plan. Have the bag packed. Know the fastest route. Show her you are ready so she feels she can depend on you. **BUY:** A comforting item for the hospital bag (her pillow from home, her favorite lip balm, a playlist she loves). **GO:** To a birthing class together if you have not already. Knowledge reduces fear. |
| **Escalation Trigger** | If fear becomes so severe she cannot discuss labor without panic attacks, refuses all birth preparation, or expresses wishes to avoid delivery entirely (extreme tokophobia) -- professional psychological support is needed. Severity 4. |
| **Cultural Variations** | **Western:** Birth fear is openly discussed. Hypnobirthing, doulas, and birth anxiety counseling are available. He should support whatever coping method she chooses. **Arabic:** Birth is often surrounded by communal female support and spiritual practices. Recitation of specific du'as and Quranic verses during labor is common and deeply comforting. He should know these if relevant to their practice. **Malay:** Traditional spiritual preparations for birth (prayers, herbal baths, bidan guidance) coexist with medical care. Both provide comfort and should be supported. |

---

## S017: She Just Got Bad News at a Prenatal Appointment

| Field | Detail |
|-------|--------|
| **Situation ID** | S017 |
| **Category** | Pregnancy |
| **Situation** | A prenatal test or ultrasound has revealed a concern: an abnormal screening result, a growth issue, a structural finding, or a complication like gestational diabetes or preeclampsia risk. The news may be definitive or ambiguous (requiring further testing). |
| **Severity** | 4 (Severe) |
| **Her Likely Emotional State** | Devastated, terrified, and potentially in shock. If the news is ambiguous, the uncertainty is agonizing. She may blame herself ("Did I do something wrong?"). She may cycle rapidly between hope and despair. She needs to process the information emotionally before she can engage with it logistically. Pressuring her to "make a plan" immediately is harmful. |
| **What He Thinks He Should Do** | Immediately research the condition. Push for action items. Try to stay positive ("It could be nothing"). Make it about his own fear. |
| **What She Actually Needs** | First: emotional presence. Hold her. Let her cry. Do not rush to solutions. Second: shared grief or fear -- "I'm scared too. We're in this together." Third (when she is ready): collaborative information-gathering with her doctor, not Dr. Google. Fourth: reassurance that he loves this baby and her regardless of outcome. No rushing to decisions. |
| **Recommended Message Tone** | Deeply compassionate, steady, non-rushing |
| **Sample Message** | "I am right here. Whatever this means, we face it together. You did nothing wrong. Let's take this one step at a time, and the first step is just... being together right now." |
| **Action Card Suggestion** | **SAY:** "This doesn't change anything about how much I love you and our baby." **DO:** Hold her. Clear the schedule. Be present for every follow-up appointment. **BUY:** Nothing right now -- this is not a gesture moment. **GO:** To the next appointment together. Take notes. Ask questions. Be her co-advocate. |
| **Escalation Trigger** | If the news involves a serious diagnosis, the couple may need grief counseling, genetic counseling, or specialized psychological support. If she shows signs of acute stress disorder (numbing, dissociation, flashbacks to the appointment, inability to function) -- professional support immediately. Severity 4-5. |
| **Cultural Variations** | **Western:** Medical information-sharing is expected and encouraged. She may want to research together. Second opinions are normalized. **Arabic:** Family may need to be involved in processing the news and making decisions. This is culturally appropriate and should not be resisted. Spiritual framing ("This is Allah's will, and we trust His plan") may provide genuine comfort. He should hold space for both medical and spiritual processing. **Malay:** Similar to Arabic -- family and spiritual support systems activate during medical crises. The bidan, the imam, and the doctor may all be consulted. He should coordinate and support her through all channels of care. |

---

# Category 3: Postpartum Situations

> **Cross-reference:** LOLO-PSY-001, Sections 3.1-3.6 (Postpartum)

---

## S018: Sleep Deprivation with Newborn

| Field | Detail |
|-------|--------|
| **Situation ID** | S018 |
| **Category** | Postpartum |
| **Situation** | The baby is waking every 2-3 hours. She has not had more than 3 consecutive hours of sleep in weeks. She is a shell of herself -- forgetful, tearful, clumsy, and running on adrenaline. She may be breastfeeding, which means she cannot fully hand off nighttime duties. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Operating in survival mode. Cognitive function is impaired. Emotional regulation is severely compromised -- she may cry at a dropped spoon or laugh at nothing. She may resent him if he sleeps through feedings or does not share the nighttime burden. Sleep deprivation is classified as a form of torture for a reason; she is experiencing it daily. Underneath everything is a desperate need for someone to take over so she can sleep. |
| **What He Thinks He Should Do** | "She's breastfeeding, so there's nothing I can do at night." Sleep in another room to "be functional for work." Tell her to nap when the baby naps (as if that is always possible). |
| **What She Actually Needs** | Shared nighttime duties: he handles diaper changes, settling, and burping even if she must do the feeding. At least one 4-5 hour uninterrupted sleep block for her per day (he takes the baby to another room with pumped milk or formula). Active daytime support so she can nap. Zero complaints about his own tiredness unless he has genuinely matched her sleep loss. Validation: "You're running on nothing and still being an incredible mom." |
| **Recommended Message Tone** | Supportive, action-oriented, admiring |
| **Sample Message** | "You've been running on no sleep, and I see how hard you're working. Tonight I'm taking over everything except the feeding. You are sleeping. That's not a suggestion -- it's a plan." |
| **Action Card Suggestion** | **SAY:** "You need sleep more than anything. Let me handle the next stretch." **DO:** Take the baby after feeding so she can sleep. Handle all non-feeding nighttime tasks. During the day, take the baby for a walk so she gets quiet time. **BUY:** Earplugs and an eye mask for her sleep blocks. Ready-made meals so nobody has to cook. **GO:** Take the baby out of the house for an hour so she has silence. |
| **Escalation Trigger** | If sleep deprivation is combined with inability to sleep even when the baby sleeps, persistent crying spells, emotional numbness, or expressed hopelessness -- screen for PPD. Severity 4. |
| **Cultural Variations** | **Western:** He is expected to share nighttime duties. The "equal parenting" ideal applies from day one. **Arabic:** During nifas (40-day confinement), female relatives often share nighttime care. He should ensure this support network is in place and supplement it. If they are managing alone, nighttime duty-sharing is essential regardless of cultural norms. **Malay:** During pantang (44-day confinement), the confinement lady or family members assist with baby care. He should coordinate with these helpers and ensure she gets adequate rest within the traditional framework. |

---

## S019: Body Image Post-Birth

| Field | Detail |
|-------|--------|
| **Situation ID** | S019 |
| **Category** | Postpartum |
| **Situation** | Her body has been through pregnancy, labor, and delivery. She may have a C-section scar, stretch marks, loose skin, a changed breast shape, or significant weight retention. She is confronting a body that looks and feels unfamiliar. "Bounce back" culture on social media shows celebrities in bikinis weeks after giving birth. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Grief for her pre-baby body, combined with guilt for caring about her appearance when she "should" be focused on the baby. She feels unattractive and fears her partner agrees. She may avoid mirrors, avoid sex, or refuse to be photographed. The gap between media portrayals and her reality is demoralizing. She needs to hear that her body is beautiful NOW, not that it will be beautiful again "once she loses the weight." |
| **What He Thinks He Should Do** | Offer to help her exercise. Suggest a diet. Say "You just had a baby, give it time" (implies the current body is a problem to be fixed). Avoid looking at her body. Compare her to other new moms who "bounced back." |
| **What She Actually Needs** | Vocal, specific, repeated affirmation of her beauty and his desire. Not future-tense ("You'll get your body back") but present-tense ("I love your body right now, today"). Physical affection: touch her, hold her, look at her with desire. Zero weight or diet commentary. Protection from "bounce back" messaging. Recognition that her body performed a miracle and deserves reverence, not criticism. |
| **Recommended Message Tone** | Intimate, affirming, present-tense |
| **Sample Message** | "Your body just did something extraordinary. Every mark, every change -- that is the map of bringing our child into the world. I have never felt more connected to you. You are beautiful to me, right now, exactly as you are." |
| **Action Card Suggestion** | **SAY:** "I love your body. Not the old version, not a future version -- this one, right now." **DO:** Initiate physical affection. Look at her with visible admiration. Touch her gently and reverently. **BUY:** Something luxurious for her body -- a soft robe, premium body cream, comfortable beautiful loungewear. NOT gym equipment or diet supplements. **GO:** Nowhere pressured. When she is ready, a gentle outing where she can feel good -- a spa day, a slow lunch, a walk in a beautiful place. |
| **Escalation Trigger** | If body image distress becomes severe (refusing to eat, excessive exercise, self-harm, expressing she is "disgusting" or "ruined"), flag for postpartum body dysmorphia or co-occurring PPD. Severity 3-4. |
| **Cultural Variations** | **Western:** "Bounce back" culture is the primary toxic influence. He should actively counter it. "Your body is healing, not failing." **Arabic:** Postpartum body care is part of the nifas tradition (belly binding, herbal treatments). These practices support recovery without the toxic "bounce back" framing. He should affirm her beauty within cultural beauty norms while never pressuring weight loss. **Malay:** "Bengkung" (belly binding) and traditional body treatments during pantang support physical recovery. He should support these traditions and consistently affirm her beauty. |

---

## S020: Feeling Overwhelmed as a New Mom

| Field | Detail |
|-------|--------|
| **Situation ID** | S020 |
| **Category** | Postpartum |
| **Situation** | She is drowning in the relentlessness of newborn care. Feeding, changing, soothing, cleaning, repeating. She may feel she has lost her identity -- she is "just a mom" now. She may express that she is failing, that the baby deserves better, or that she was not prepared for how hard this would be. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Overwhelmed, inadequate, and isolated. She compares herself to the "natural mother" ideal and falls short. She may love her baby fiercely while also mourning her former life -- and feel guilty about the mourning. She needs someone to tell her that this is the hardest job in the world and she is doing it. She needs tangible help, not just words. |
| **What He Thinks He Should Do** | Say "You're a great mom" and go back to what he was doing. Suggest she "enjoy it because it goes fast." Leave most of the baby care to her because "she's better at it." Focus on providing financially as his contribution. |
| **What She Actually Needs** | Active co-parenting: he takes the baby without being asked. Time that is entirely hers -- not "running errands" but actual rest or enjoyment. Validation of the difficulty: "This is the hardest thing you've ever done, and you're doing it beautifully." Recognition that she is still a person, not just a mother: ask about HER, not just the baby. Practical help that is consistent, not one-off heroics. |
| **Recommended Message Tone** | Validating, relieving, action-oriented |
| **Sample Message** | "I know this is so much harder than anyone warned us. You are not failing -- you are learning the hardest job on earth in real-time. I'm taking the baby for the next three hours. You do whatever you want -- sleep, shower, stare at the ceiling. This is your time." |
| **Action Card Suggestion** | **SAY:** "You are an incredible mother. And you are still an incredible woman. I see both." **DO:** Take the baby for multiple hours so she can be alone. Handle a full feeding/changing/nap cycle independently. **BUY:** A meal delivery subscription so nobody has to cook. Something just for HER, not baby-related. **GO:** Take the baby out of the house. Give her silence and solitude. |
| **Escalation Trigger** | If overwhelm persists beyond the first 6 weeks, if she expresses hopelessness ("I can't do this"), worthlessness ("The baby deserves a better mother"), or detachment from the baby -- screen for PPD. Severity 3-4. |
| **Cultural Variations** | **Western:** Isolated nuclear family structure means she may have minimal support. He is the primary backup. Professional postpartum support (doulas, night nurses) should be considered if affordable. **Arabic:** Nifas support from female relatives is designed precisely for this situation. He should ensure the support is in place and advocate for her needs within the family structure. **Malay:** Pantang confinement provides built-in support. He should ensure the confinement lady or family helpers are actually supporting her, not adding stress (some women feel controlled rather than cared for during pantang). |

---

## S021: Baby Blues (Mild Postpartum Mood Disturbance)

| Field | Detail |
|-------|--------|
| **Situation ID** | S021 |
| **Category** | Postpartum |
| **Situation** | She is 2-10 days postpartum and experiencing tearfulness, mood swings, irritability, and anxiety that seem disproportionate to the situation. She may cry while feeding the baby, cry at a commercial, or suddenly feel overwhelmed by tenderness. This is baby blues -- experienced by up to 80% of new mothers. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Emotionally raw. Hormones are crashing from their pregnancy peak. She may feel guilty about not being purely happy ("I wanted this baby, why am I crying?"). She is confused by the intensity of her emotions. She needs to know this is normal, temporary, and not a reflection of her adequacy as a mother. |
| **What He Thinks He Should Do** | Worry that something is seriously wrong. Try to cheer her up. Ask her what is wrong (she does not know). Feel helpless and withdraw. |
| **What She Actually Needs** | Normalization: "This is your body adjusting. It happens to almost every new mom. It doesn't mean anything is wrong with you." Physical comfort: hold her while she cries. Patience: let the tears flow without trying to fix them. Consistent care: ensure she is eating, sleeping as much as possible, and not isolated. Watchful support: baby blues resolve within 2 weeks; if they do not, the approach must shift. |
| **Recommended Message Tone** | Normalizing, warm, patient |
| **Sample Message** | "It's okay to cry. Your body has been through the most incredible thing, and your hormones are adjusting. This is normal, and it will pass. I'm right here, and I love you through every tear." |
| **Action Card Suggestion** | **SAY:** "You don't have to explain the tears. I'm just going to hold you." **DO:** Sit with her. Let her cry without trying to fix it. Ensure she eats and drinks water. Take on as much baby care as possible. **BUY:** Comfort items: her favorite tea, a soft blanket, something that smells good. **GO:** Nowhere unless she wants fresh air. A short, gentle walk can help if she is willing. |
| **Escalation Trigger** | If symptoms persist beyond 2 weeks, intensify rather than improve, or include inability to bond with the baby, intrusive thoughts, or expressions of worthlessness -- this has likely transitioned to PPD. Escalate to Severity 4. Recommend professional screening. |
| **Cultural Variations** | **Western:** Baby blues are widely recognized in medical and popular culture. He can name it: "This is what they call baby blues. It's really common and it'll pass." **Arabic:** Postpartum emotional fragility may be attributed to spiritual causes or the "evil eye." He should validate both cultural and medical framings without dismissing either. The nifas support network is protective against isolation. **Malay:** Traditional postpartum care during pantang includes emotional support from elder women. He should ensure she has this support and supplement it with his own presence. |

---

## S022: Warning Signs of Postpartum Depression (PPD)

| Field | Detail |
|-------|--------|
| **Situation ID** | S022 |
| **Category** | Postpartum |
| **Situation** | It has been more than 2 weeks since birth and she is not improving. She may be persistently sad, empty, or numb. She may be withdrawing from the baby, the partner, or everyone. She may express that she is a terrible mother, that the baby does not love her, or that everyone would be better off without her. She may be unable to sleep even when the baby sleeps, or sleeping excessively. She may have lost interest in everything. |
| **Severity** | 4 (Severe) |
| **Her Likely Emotional State** | She is in clinical depression. Her brain chemistry has been disrupted by the hormonal crash of postpartum combined with sleep deprivation, identity upheaval, and the relentlessness of newborn care. She may not recognize that she is depressed -- she may think this is just what motherhood feels like. She may feel too ashamed to ask for help because "good mothers" are supposed to be happy. She is suffering, and she needs professional support. |
| **What He Thinks He Should Do** | Wait for it to pass. Tell her to be grateful for the healthy baby. Suggest she exercise or get out more. Feel helpless and possibly resentful that she is "not coping." Avoid the conversation because it scares him. |
| **What She Actually Needs** | A partner who takes the lead on getting help. He must gently but clearly raise the concern: "I love you, and I'm worried about you. I think talking to your doctor could really help. This isn't weakness -- this is your body asking for support." He should make the appointment, drive her there, and sit in the waiting room. He should continue to share baby care, protect her sleep, and express love and admiration consistently. He should never blame her, pressure her to "try harder," or imply that her depression is a choice. |
| **Recommended Message Tone** | Serious, loving, action-oriented |
| **Sample Message** | "I need you to hear me: you are not failing. What you're feeling is not your fault, and it's not something you should push through alone. I've been reading about postpartum depression, and I think talking to your doctor could make a real difference. I'll go with you. I'll hold your hand the entire time. You deserve to feel like yourself again." |
| **Action Card Suggestion** | **SAY:** "I see you struggling, and I love you too much to pretend it's okay. Let's get help together." **DO:** Research PPD-specialized therapists or call her OB to discuss screening. Take over as much baby care as humanly possible. Ensure she is never alone for extended periods if she is expressing hopelessness. **BUY:** Nothing material can address this. Invest time, presence, and professional resources. **GO:** To the doctor together. To a therapist if she is willing. |
| **Escalation Trigger** | If she expresses thoughts of self-harm, thoughts of harming the baby, inability to care for the baby, or makes statements like "they'd be better off without me" -- this is Severity 5. Immediate professional intervention. Display crisis resources. The app must clearly state: "This is beyond what LOLO can help with. Please contact a healthcare professional immediately." |
| **Cultural Variations** | **Western:** PPD awareness is high but stigma remains. Frame therapy as strength. Many women respond to knowing that PPD is a medical condition, not a character flaw. **Arabic:** PPD may be misidentified as spiritual weakness, lack of faith, or the "evil eye." He must gently bridge cultural understanding and medical reality: "This is a medical condition, like diabetes after pregnancy. Your doctor can help. It has nothing to do with your faith or your strength as a mother." **Malay:** PPD stigma exists. Frame professional help as complementary to traditional postpartum care: "The bidan is helping your body heal. A doctor can help your mind heal too. Both are important." |

---

## S023: She Resents Him for Not Understanding What She Is Going Through

| Field | Detail |
|-------|--------|
| **Situation ID** | S023 |
| **Category** | Postpartum |
| **Situation** | She feels that he does not understand the depth of what postpartum life demands. He seems to carry on with his normal routine -- going to work, seeing friends, sleeping through the night -- while she is drowning. Her resentment is building, and it may explode as anger, withdraw as coldness, or simmer as passive-aggressive comments. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Furious and heartbroken. She expected partnership and is experiencing abandonment. She may feel trapped in a role she cannot escape while he has the freedom she has lost. The resentment is corrosive -- left unaddressed, it will permanently damage the relationship. She needs him to see the imbalance and correct it without her having to beg. |
| **What He Thinks He Should Do** | Get defensive ("I'm working to support this family!"). Point out what he does do. Tell her other couples manage fine. Feel attacked and withdraw. |
| **What She Actually Needs** | Acknowledgment of the imbalance without defensiveness. "You're right. I haven't been carrying my share, and that's not fair to you." Immediate, visible behavioral change -- not promises, action. Equal sacrifice: if she cannot see friends, he should not be seeing friends. If she is up at night, he should be up at night. Genuine curiosity: "Tell me what your day really looks like. I want to understand." |
| **Recommended Message Tone** | Humble, accountable, action-committed |
| **Sample Message** | "I owe you an honest conversation. I know I haven't been carrying my weight since the baby came. I see how much you're doing, and I see how unfair the balance has been. I'm not going to just promise to do better -- I'm going to show you, starting tonight. What do you need me to take over?" |
| **Action Card Suggestion** | **SAY:** "You're right to be frustrated. I haven't been doing enough, and that changes now." **DO:** Immediately take on a significant, recurring task -- nighttime feeding with pumped milk, all diaper changes during a time block, solo baby care for set hours daily. **BUY:** Not applicable -- gestures will feel hollow if the imbalance persists. **GO:** Nowhere without her agreement. Cancel your own social plans if she has had to cancel hers. |
| **Escalation Trigger** | If resentment has calcified into contempt (a Gottman "Four Horsemen" predictor of relationship breakdown), couples counseling is urgently needed. If she has stopped communicating entirely, the disconnection may already be severe. Severity 4. |
| **Cultural Variations** | **Western:** The expectation of equal parenting is strong. His failure to meet it is culturally condemned, which may add to her sense of justified anger. He must step up. **Arabic:** The division of labor may be culturally different (he provides, she nurtures), but even within traditional frameworks, her emotional needs must be met. He can contribute through acts of service, emotional presence, and ensuring she has the family support she needs. He should not hide behind cultural norms to avoid pulling his weight. **Malay:** Similar to Arabic -- traditional roles exist but are not excuses for emotional neglect. He can contribute meaningfully within the pantang framework by being emotionally present, managing the household, and protecting her rest. |

---

# Category 4: Emotional Crisis Situations

> **Cross-reference:** LOLO-PSY-001, Sections 5.1-5.7 (General Stress Responses), Section 6 (Emotional Temperature Model), Section 8 (Escalation Protocol)

---

## S024: She Found Out He Lied About Something

| Field | Detail |
|-------|--------|
| **Situation ID** | S024 |
| **Category** | Emotional Crisis |
| **Situation** | She discovered a lie -- it could be about where he was, who he was with, money he spent, a message she found, or a promise he broke. The severity of the lie varies, but the discovery of deception is always emotionally significant. |
| **Severity** | 4 (Severe) |
| **Her Likely Emotional State** | Betrayed. The lie itself may be minor, but the act of deception shatters trust. She is questioning what else he has lied about. Her mind is building a case of every suspicious moment, reinterpreting his past behavior through a lens of dishonesty. She feels foolish for trusting him. She may oscillate between rage and devastation. The foundation of safety in the relationship has cracked. |
| **What He Thinks He Should Do** | Minimize the lie ("It was nothing"). Deflect blame ("I only lied because you would have overreacted"). Get angry that she found out. Demand she "move on" quickly. |
| **What She Actually Needs** | Full, honest, non-defensive accountability. "I lied. There is no excuse. I was wrong." No minimizing, no deflecting, no blaming her reaction. Answers to her questions -- she has the right to ask. Patience with her timeline for rebuilding trust -- this is not resolved in one conversation. Understanding that trust is rebuilt through consistent, transparent behavior over time, not through apologies alone. |
| **Recommended Message Tone** | Accountable, humble, patient |
| **Sample Message** | "I owe you the truth, and I owe you an apology without excuses. I lied, and that was wrong. I understand if you're angry, hurt, and questioning everything. I will answer any question you have, and I will work to earn your trust back for as long as it takes." |
| **Action Card Suggestion** | **SAY:** "I was wrong. No excuses. Ask me anything." **DO:** Be completely transparent going forward. Share your phone, your calendar, your whereabouts without being asked. Demonstrate trustworthiness through consistency. **BUY:** Not applicable -- gifts will feel like bribes. **GO:** To couples counseling if the breach is significant and she is willing. |
| **Escalation Trigger** | If the lie involves infidelity, financial deception, or a pattern of dishonesty -- couples therapy is essential. If she spirals into obsessive checking, inability to function, or severe anxiety -- individual therapy for her as well. If the relationship has become a cycle of lies and discovery -- Severity 4-5. The app must not enable a cycle of deception. |
| **Cultural Variations** | **Western:** Direct confrontation is expected and accepted. She may demand transparency, space, or counseling. All are valid. **Arabic:** The discovery of a lie carries deep honor implications. Family may become involved. He must manage the situation with dignity and accountability. If the lie involves another woman, the cultural stakes are extremely high. The AI must navigate carefully without inflaming or minimizing. **Malay:** "Menjaga air muka" (saving face) is important, but so is accountability. She may process the betrayal privately before confronting him. When she does confront, he must receive it with humility. Public exposure of the lie would be devastating for both. |

---

## S025: Big Argument -- She Is Not Speaking to Him

| Field | Detail |
|-------|--------|
| **Situation ID** | S025 |
| **Category** | Emotional Crisis |
| **Situation** | They had a significant argument and she has gone silent. She may be in another room, at her mother's house, or simply refusing to engage. The silence is not passive -- it is communicating pain, anger, and a need for him to recognize the severity of what happened. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Deeply hurt, possibly exhausted from the argument, and testing whether he will pursue repair or wait for her to come around. Her silence is a form of self-protection -- she is too hurt or too angry to trust herself to speak without making things worse. She may also be evaluating the relationship: "Is this the pattern we're going to live with?" She needs him to make the first move toward repair, but not immediately -- she needs some space first. |
| **What He Thinks He Should Do** | Match her silence. Wait for her to speak first. Text "Are you done yet?" Send a half-hearted "Sorry if I upset you." Give her days of space and pretend nothing happened. |
| **What She Actually Needs** | Space first (hours, not days), then a genuine, vulnerable approach. Not "Can we just move on?" but "I know I hurt you. I've been thinking about what happened, and I want to understand how you're feeling." He should approach with humility, not frustration. He should not demand a timeline for resolution. He should acknowledge his part without "but" statements ("I'm sorry, BUT you also..."). |
| **Recommended Message Tone** | Humble, patient, repair-oriented |
| **Sample Message** | "I know you need space right now, and I respect that. When you're ready, I want to listen -- really listen -- to what you're feeling. I don't want to be right. I want to be close to you again." |
| **Action Card Suggestion** | **SAY:** "I miss you. I'm sorry for my part in this. Whenever you're ready, I'm here." **DO:** After giving space (a few hours), make a gentle approach. A cup of tea brought silently. A note under the door. Do not force conversation. **BUY:** Not applicable during active conflict -- it feels manipulative. **GO:** Do not leave the house in anger. Stay near but not intrusive. |
| **Escalation Trigger** | If silence extends beyond 48 hours with no softening, if arguments are becoming more frequent and severe, or if either partner uses contemptuous language (name-calling, mocking, eye-rolling) -- couples counseling is needed. Severity 4. |
| **Cultural Variations** | **Western:** Direct conversation about the argument is expected eventually. She may want to "talk it out." He should be ready to engage without being defensive. **Arabic:** She may go to her family home during a severe argument. This is culturally normal and should not be interpreted as leaving the relationship. He should give her time, then approach through appropriate channels (possibly through her mother or a family mediator). **Malay:** "Merajuk" (sulking as emotional communication) is a recognized relationship dynamic. It is her way of expressing hurt. He should respond with patience and gentle pursuit, not irritation. Ignoring the merajuk is interpreted as not caring. |

---

## S026: She Is Crying and Will Not Say Why

| Field | Detail |
|-------|--------|
| **Situation ID** | S026 |
| **Category** | Emotional Crisis |
| **Situation** | She is visibly upset -- tears, withdrawn body language, possibly shaking or curled up. When he asks what is wrong, she says "Nothing" or "I don't know" or shakes her head. She genuinely may not be able to articulate the cause. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Emotionally flooded. The tears may be about one thing, many things, or a cumulative weight that finally broke through. She may not have the language for what she feels, or she may not trust that he will understand. She wants his presence, not his interrogation. She needs to feel safe enough to fall apart without having to explain or justify the falling. |
| **What He Thinks He Should Do** | Keep asking "What's wrong?" Get frustrated by the lack of answer. Assume he did something. Try to solve an unsolvable problem. Leave her alone because "she said nothing." |
| **What She Actually Needs** | Quiet, warm presence. Sit beside her. Hold her if she is receptive. Do not demand an explanation. Say "I'm here" and mean it. Let the tears flow without judgment or urgency. If she eventually talks, listen without interrupting. If she does not talk, that is okay too -- the comfort of his presence is the response. |
| **Recommended Message Tone** | Soft, present, patient |
| **Sample Message** | "You don't have to explain anything. I'm just going to sit here with you. Whenever you're ready to talk, I'm listening. And if you're never ready, that's okay too. I'm still here." |
| **Action Card Suggestion** | **SAY:** "I'm here. You don't owe me an explanation." **DO:** Sit beside her. Put an arm around her. Bring her water or tea. Turn off the TV or put your phone away. Be fully present. **BUY:** Not applicable. **GO:** Nowhere. Stay. |
| **Escalation Trigger** | If crying episodes are frequent (daily or near-daily) for more than 2 weeks, or if she becomes inconsolable for extended periods, or if she expresses hopelessness or self-harm thoughts during the episode -- escalate to Severity 3-4. Suggest professional support. |
| **Cultural Variations** | **Western:** He can acknowledge the emotion directly: "I can see you're hurting. I'm here." Physical comfort is generally welcome. **Arabic:** She may resist showing vulnerability because cultural norms discourage overt emotional display. If she is crying in front of him, the trust is significant. He should honor it with quiet warmth. Do not involve family in this moment. **Malay:** Physical presence and warmth are powerful. She may not want to talk but will feel comforted by his nearness. A warm drink offered silently is a culturally fluent gesture of care. |

---

## S027: She Is Stressed About Work or Career

| Field | Detail |
|-------|--------|
| **Situation ID** | S027 |
| **Category** | Emotional Crisis |
| **Situation** | She is dealing with a difficult boss, a heavy workload, a career setback, imposter syndrome, or a workplace conflict. She comes home tense, distracted, or venting about her day. She may feel that her professional competence is being questioned or that she is stuck. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Frustrated, self-doubting, and exhausted. Work stress for women often carries additional layers: gender dynamics, being taken less seriously, pressure to prove herself, and the internal conflict between ambition and other life demands. She needs to process verbally -- this is not complaining, it is cognitive processing. She wants someone to believe in her competence even when she is struggling to believe in it herself. |
| **What He Thinks He Should Do** | Offer solutions immediately. Tell her to quit. Minimize the problem. Pivot to his own work stress. Tell her not to let it bother her. |
| **What She Actually Needs** | To be heard first and fixed never (unless she asks). The question "Do you want me to listen or help problem-solve?" is genuinely powerful. Validation of her competence: "You are brilliant at what you do. This situation is difficult, but you are not." Practical home support on high-stress work days: handle dinner, manage the household, give her decompression time. |
| **Recommended Message Tone** | Affirming, listening, competence-validating |
| **Sample Message** | "I can hear how heavy today was. You work so hard, and it's not fair that you're dealing with this. Want to vent, or do you want ideas? Either way, I've got dinner covered tonight." |
| **Action Card Suggestion** | **SAY:** "You're good at what you do. This is a tough situation, not a reflection of your ability." **DO:** Take over household duties on her stressful days. Create a decompression space when she gets home. **BUY:** Her favorite unwind treat -- wine, chocolate, a bath bomb. **GO:** Nowhere demanding. A quiet dinner out where she can decompress, or a peaceful evening at home. |
| **Escalation Trigger** | If work stress is causing persistent insomnia, anxiety attacks, or depression symptoms -- suggest she speak with a therapist. If work stress is due to harassment or discrimination, she may need legal or HR guidance beyond what the app can provide. Severity 3-4. |
| **Cultural Variations** | **Western:** Career identity is central. Her work stress is identity stress. Validate both. **Arabic:** Career for women in GCC contexts is evolving rapidly. She may face unique pressures balancing professional ambition with cultural expectations. He should unequivocally support her career without framing it as secondary to family roles. **Malay:** Work-family balance pressure is significant. She may feel guilty about working if she has children. He should affirm her right to a career and her value as a professional. |

---

## S028: She Lost a Family Member or Friend

| Field | Detail |
|-------|--------|
| **Situation ID** | S028 |
| **Category** | Emotional Crisis |
| **Situation** | Someone she loves has died. This could be a parent, sibling, grandparent, close friend, or anyone significant. The loss may be sudden or expected; either way, grief has arrived and will reshape her emotional landscape for a long time. |
| **Severity** | 4 (Severe) |
| **Her Likely Emotional State** | Shattered. Grief is not one emotion -- it is an ocean of them: sadness, anger, guilt, regret, numbness, disbelief, yearning. She may function normally for hours and then collapse. She may want to talk about the person constantly or not at all. She may seem "fine" and then be triggered by a song, a smell, or a memory. Grief has no timeline and no logic. She needs her partner to be her anchor without trying to be her therapist. |
| **What He Thinks He Should Do** | Say "Everything happens for a reason." Try to distract her from grief. Set a timeline for "moving on." Avoid talking about the deceased because it might upset her. Feel helpless and withdraw. |
| **What She Actually Needs** | Presence. Simply being there -- physically, emotionally, consistently. He should say the deceased person's name. He should ask her to tell him stories. He should hold her when she cries and sit with her in silence when she cannot cry. He should handle logistics (food, calls, arrangements) so she can grieve. He should remember the dates -- anniversaries, birthdays, the death date. A message on those dates, months or years later, says "I remember, and I care." |
| **Recommended Message Tone** | Gentle, present, naming the loss |
| **Sample Message** | "I am so sorry. I loved [name] too, and I know how much they meant to you. I'm here for whatever you need -- whether that's talking, crying, sitting in silence, or anything else. There's no right way to do this. I'm just going to be here." |
| **Action Card Suggestion** | **SAY:** "Tell me about [name]. I want to remember them with you." **DO:** Handle practical matters (food for the household, informing people, managing schedules). Be present at the funeral and any gatherings. Hold her. Let her grieve her way. **BUY:** Flowers for the memorial. A framed photo of her with the deceased. **GO:** To the funeral, the memorial, and anywhere she needs to be. Do not let her face it alone. |
| **Escalation Trigger** | If grief becomes "stuck" (persistent complex bereavement) -- inability to function for more than 6 months, inability to accept the reality of the loss, severe depression, self-harm thoughts, or substance use to cope -- professional grief counseling is needed. Severity 4-5. |
| **Cultural Variations** | **Western:** Grief expression is relatively open. Funerals and memorial services are the primary rituals. Therapy for grief is normalized. **Arabic:** Islamic bereavement practices are structured and meaningful -- 3 days of mourning, 40-day observance, prayer for the deceased. He should participate fully in these rituals and ensure she has access to her female support network during mourning. The community rallies around the bereaved; he should facilitate this. **Malay:** Bereavement practices combine Islamic ritual with local customs. Communal support (gotong-royong) is strong during mourning. He should participate in all mourning rituals and ensure she is surrounded by support. Tahlil (prayer gatherings) for the deceased are important. |

---

## S029: She Feels Taken for Granted

| Field | Detail |
|-------|--------|
| **Situation ID** | S029 |
| **Category** | Emotional Crisis |
| **Situation** | She feels that her contributions -- to the household, the relationship, the family, or his life -- are invisible. She cooks, cleans, manages the mental load, remembers appointments, buys gifts for his family, and none of it is acknowledged. She is tired of being the engine that no one notices until it stops running. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Exhausted, bitter, and heartbroken. This is one of the deepest emotional wounds in long-term relationships. She does not want a medal -- she wants to be seen. She wants him to notice without being told. She wants gratitude that is specific and consistent, not a one-time "I appreciate everything you do" after she has had a breakdown. She may be questioning whether the relationship is worth the invisible labor. |
| **What He Thinks He Should Do** | Get defensive ("I do things too!"). List his own contributions. Buy flowers as a quick fix. Promise to "do better" without changing behavior. |
| **What She Actually Needs** | Genuine acknowledgment of the specific things she does. Not "You do so much" but "I noticed you organized the kids' school stuff, called my mother for her birthday, and still made dinner even though you were exhausted. I see you, and I'm grateful." Behavioral change that is sustained, not performative. He should take on tasks permanently, not just help when asked. He should express gratitude daily, not just during crises. |
| **Recommended Message Tone** | Grateful, specific, accountable |
| **Sample Message** | "I owe you something I should have said a long time ago. I see everything you do -- the things I never think about because you just handle them. You keep our life running, and I have not thanked you enough. That changes now. Starting today, I want to carry more of this weight. Tell me what to take off your plate -- permanently." |
| **Action Card Suggestion** | **SAY:** Name three specific things she did this week and thank her for each one. **DO:** Take over a recurring task she always handles -- and do it without being reminded, consistently. **BUY:** A thoughtful gift that shows you pay attention to her preferences, not a generic apology gift. **GO:** Take her somewhere she has mentioned wanting to go -- proving you listen. |
| **Escalation Trigger** | If she has reached the point of contempt (Gottman's most dangerous relationship indicator) -- expressing disgust, mocking him, or no longer caring about his response -- the relationship is in critical danger. Couples counseling is urgent. Severity 4. |
| **Cultural Variations** | **Western:** The "mental load" discourse is increasingly mainstream. She may use this language. He should engage with it genuinely, not dismissively. **Arabic:** Her labor may include significant family management (his family obligations, household management, social hosting). Acknowledging this within the cultural framework is important. He should express gratitude in terms that carry cultural weight: "You are the heart of this home." **Malay:** Similar to Arabic. Her contributions to family harmony ("menjaga keluarga") are immense and often invisible. He should acknowledge them publicly (in front of family) and privately. |

---

## S030: She Suspects He Does Not Find Her Attractive Anymore

| Field | Detail |
|-------|--------|
| **Situation ID** | S030 |
| **Category** | Emotional Crisis |
| **Situation** | She has noticed a decline in his physical attention -- less frequent sex, fewer compliments, less physical touch, he does not look at her the way he used to. She is constructing a narrative that he has lost attraction, and she is interpreting every behavior through that lens. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Deeply insecure and preemptively heartbroken. She is preparing for rejection. She may start dressing differently (either trying harder or giving up), becoming self-critical, or pulling away from intimacy to protect herself from the sting of perceived rejection. This fear sits at the intersection of her deepest vulnerabilities: desirability, lovability, and sexual worth. |
| **What He Thinks He Should Do** | Say "Of course I find you attractive" in a flat, unconvincing tone. Initiate sex as "proof" without emotional connection. Get annoyed that she is "insecure." Ignore the issue entirely. |
| **What She Actually Needs** | Active, enthusiastic, specific demonstrations of desire. Not "You're pretty" but "I could not take my eyes off you today." Initiated physical affection that is not always a prelude to sex -- touch that says "I want to be close to you." Eye contact. Compliments that reference her specifically, not generic beauty. Behavioral consistency: this is not a one-night fix. |
| **Recommended Message Tone** | Passionate, specific, desire-expressing |
| **Sample Message** | "I need to tell you something, and I need you to really hear it. You are the most attractive person in my world. I realize I haven't been showing it enough, and that's on me -- not because it's not true, but because I got lazy about saying it. Let me fix that, starting right now: you took my breath away today." |
| **Action Card Suggestion** | **SAY:** Specific, desire-based compliments daily. Not duty, not reassurance -- genuine expressed desire. **DO:** Initiate physical affection multiple times daily. Look at her. Really look. **BUY:** Something that communicates "I desire you" -- lingerie (only if she would welcome it), perfume, an intimate experience. **GO:** On a date that makes her feel desired -- a restaurant where you can dress up, a weekend away, a setting that recreates early-relationship energy. |
| **Escalation Trigger** | If her self-worth is severely impacted (disordered eating, self-harm, depressive symptoms, sexual aversion), or if the issue is actually rooted in his loss of attraction (which the app cannot assess) -- couples and/or individual therapy. Severity 3-4. |
| **Cultural Variations** | **Western:** Direct conversation about attraction and desire is culturally available. She may bring it up explicitly. He should engage honestly and warmly. **Arabic:** Physical desire and attraction within marriage are celebrated Islamically. He can frame his desire within this context: "You are a blessing I don't deserve." Private expressions of desire carry deep meaning. **Malay:** "Manja" (affectionate closeness) is a culturally valued dynamic. He should increase manja behaviors -- gentle touch, sweet words, attentive care. She may not ask directly but craves the reassurance. |

---

## S031: She Is Comparing Their Relationship to Others

| Field | Detail |
|-------|--------|
| **Situation ID** | S031 |
| **Category** | Emotional Crisis |
| **Situation** | She is looking at other couples (on social media, among friends, in media) and feeling that their relationship falls short. "Why don't we do things like that?" or "She's so lucky her husband does that" or silent comparison that manifests as dissatisfaction. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Disappointed and questioning. She is not comparing for sport -- she is expressing unmet needs through the lens of what she sees others receiving. The comparison is a symptom, not the disease. Underneath it is: "I want to feel special. I want to feel prioritized. I see other women getting something I'm not getting, and it hurts." |
| **What He Thinks He Should Do** | Get defensive ("You don't see what happens behind closed doors"). Criticize her for comparing. Feel inadequate and withdraw. Dismiss social media as fake. |
| **What She Actually Needs** | Curiosity about the underlying need: "What is it about what you're seeing that you'd like in our relationship? I genuinely want to know." Willingness to step up: identify what she is actually asking for (more dates, more surprises, more effort, more affection) and deliver. Honesty about his own experience: "I want to give you that. Help me understand what would make you feel special." |
| **Recommended Message Tone** | Curious, non-defensive, willing |
| **Sample Message** | "I hear you, and instead of getting defensive, I want to ask: what would make you feel more special in our relationship? I want to be the partner who makes other women jealous -- seriously. Tell me what that looks like to you." |
| **Action Card Suggestion** | **SAY:** "I want to be the partner you brag about. Tell me what you need." **DO:** Plan a surprise that shows thought and effort. Study what she is responding to in others' relationships and translate it to yours. **BUY:** Something that shows you listen: if she mentioned a friend's husband bringing flowers, bring flowers. The point is not the object but the attention. **GO:** On a date that is Instagram-worthy -- not because social media matters, but because effort and beauty in the relationship matter to her. |
| **Escalation Trigger** | If comparison becomes obsessive or if dissatisfaction has escalated to relationship-exit language ("Maybe I'd be happier with someone else"), couples counseling is recommended. Severity 3. |
| **Cultural Variations** | **Western:** Social media comparison is the primary driver. Instagram, TikTok "couple goals" content is pervasive. He should engage with her desire for romance rather than dismissing the medium. **Arabic:** Comparison may be with couples in her family or social circle rather than social media. The cultural pressure to be a "good husband" in the eyes of her family adds weight. He should respond to the need, not resist the comparison. **Malay:** Similar to Arabic. Family and social circle comparisons carry weight. He should aim to be seen as a caring, attentive husband -- both for her emotional need and for social harmony. |

---

## S032: She Said "I'm Fine" but Clearly Is Not

| Field | Detail |
|-------|--------|
| **Situation ID** | S032 |
| **Category** | Emotional Crisis |
| **Situation** | She is exhibiting signs of distress (quieter than usual, tense body language, short responses, avoiding eye contact) but when asked, insists she is fine. This is one of the most common and most mishandled dynamics in relationships. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | She is not fine. She is testing whether he cares enough to see past the verbal deflection. This is not manipulation -- it is a deeply ingrained communication pattern (especially in women socialized to minimize their needs). She may not want to burden him, or she may not trust that he will respond well if she opens up. She needs him to be gently persistent. Walking away when she says "I'm fine" fails the test. |
| **What He Thinks He Should Do** | Take "I'm fine" at face value and walk away. Feel relieved that he does not have to deal with an emotional conversation. Get frustrated: "Why won't you just tell me what's wrong?" |
| **What She Actually Needs** | Gentle persistence without aggression. Not "Tell me what's wrong!" but "I can see something is bothering you, and I'm here when you're ready. No pressure, but I'm not going to pretend I don't notice." Then: stay present. Do not leave the room. Make a warm gesture (tea, sitting beside her, a touch on her shoulder). Let her come to it in her own time. Often the dam breaks within 15-30 minutes of sustained, gentle presence. |
| **Recommended Message Tone** | Gently persistent, warm, seeing-through-the-mask |
| **Sample Message** | "I know you said you're fine, but I know you -- and something's off. You don't have to tell me right now, but I want you to know I see you, and I'm not going anywhere. Whenever you're ready, I'm listening." |
| **Action Card Suggestion** | **SAY:** "You don't have to be fine. Not with me." **DO:** Stay in the room. Make her a warm drink. Sit near her without demanding conversation. Be patient. **BUY:** Not applicable. **GO:** Nowhere. This is a presence moment. |
| **Escalation Trigger** | If "I'm fine" becomes a permanent shield and she never opens up, the emotional distance is growing and may require couples counseling. If what she eventually reveals is severe (abuse, mental health crisis, relationship-ending thoughts), respond to the content appropriately and escalate as needed. |
| **Cultural Variations** | **Western:** He can be more direct in his persistence: "I can tell you're not fine. Talk to me." **Arabic:** Indirect communication is the norm. He should read her behavioral cues and respond with care without forcing verbal disclosure. A gesture of care (bringing food, handling a task) may open the door more effectively than direct questioning. **Malay:** "Tak apa" (it's nothing) is the Malay equivalent of "I'm fine." It is deeply cultural. He should respond to the emotion, not the words. Gentle persistence and physical warmth are key. She may open up when she feels safe that he will not judge or dismiss. |

---

## S033: She Is Questioning the Relationship

| Field | Detail |
|-------|--------|
| **Situation ID** | S033 |
| **Category** | Emotional Crisis |
| **Situation** | She has expressed doubt about the relationship's future. She may have said "I don't know if this is working," "Are we right for each other?" or "I need to think about us." This may come after a long buildup of unaddressed issues or suddenly during a moment of clarity. |
| **Severity** | 4 (Severe) |
| **Her Likely Emotional State** | She has reached this point because accumulated emotional needs have gone unmet. This is rarely impulsive -- she has likely been thinking about it for weeks or months. She is grieving the relationship she hoped for while confronting the one she has. She may still love him but feel that love is not enough if the relationship does not change. She is looking for a reason to stay, but she needs to see real change, not promises. |
| **What He Thinks He Should Do** | Panic and love-bomb (sudden flowers, grand gestures, professions of love). Get angry: "After everything I've done?" Beg. Make promises without follow-through. Give an ultimatum. |
| **What She Actually Needs** | A partner who takes the conversation seriously without panicking. "I hear you, and I don't want to lose you. Tell me what's been building up -- I want to understand." Genuine accountability for patterns that have led to this moment. Willingness to go to couples therapy -- this is the moment for it. Sustained behavioral change, not a temporary performance. He should understand that this is a wake-up call, not a verdict. |
| **Recommended Message Tone** | Serious, open, non-defensive, committed |
| **Sample Message** | "I'm hearing you, and it scares me because I love you. I don't want to defend myself or make promises you've heard before. I want to actually understand what's been hurting you. And I want us to get help -- not because we're broken, but because I want to be the partner you deserve. Will you go to counseling with me?" |
| **Action Card Suggestion** | **SAY:** "I take this seriously. I don't want to lose you, and I'm willing to do the work." **DO:** Research couples therapists. Book an appointment. Start making visible changes NOW -- not next week. **BUY:** Not applicable -- gestures are hollow at this stage. **GO:** To couples therapy. This is non-negotiable. |
| **Escalation Trigger** | If she has already decided to leave and is communicating this, the app must respect her autonomy. The AI must never pressure her (through him) to stay in a relationship she has decided to leave. If the questioning is driven by abuse, the app must NEVER suggest she stay. Severity 4-5 depending on context. |
| **Cultural Variations** | **Western:** Relationship questioning is openly discussed. Couples therapy is normalized. She may reference specific relationship frameworks ("We need to work on our communication / attachment styles"). **Arabic:** Questioning the marriage is deeply serious and may involve family intervention. Divorce carries significant social stigma in many communities. He should engage her concerns privately before family involvement. Islamic counseling (with a qualified, couples-supportive imam or counselor) may be appropriate. **Malay:** Similar to Arabic. Family involvement in relationship repair is common and culturally appropriate. He should balance private couple conversations with respectful engagement of family support systems. |

---

## S034: She Caught Him Looking at or Following Attractive Women Online

| Field | Detail |
|-------|--------|
| **Situation ID** | S034 |
| **Category** | Emotional Crisis |
| **Situation** | She discovered he follows, likes, or watches content featuring attractive women on social media or elsewhere online. She may have seen his search history, his follows list, or noticed him looking. She may feel that she is being compared and losing. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Betrayed, inadequate, and humiliated. She is comparing herself to the women he is looking at and concluding she is not enough. Her body image, her sexual confidence, and her sense of being desired are all under assault. She may feel that this is a form of emotional infidelity. She may oscillate between anger ("How could you?") and devastation ("Am I not enough?"). |
| **What He Thinks He Should Do** | Minimize: "It's just Instagram / it doesn't mean anything." Get angry: "You're being crazy." Delete the evidence and lie about it. Turn it around: "Everyone does it." |
| **What She Actually Needs** | Genuine understanding of why it hurts. Not "It's nothing" but "I see why this hurts you, and I'm sorry." A willingness to stop the behavior. Choosing her comfort over a habit is the message she needs. Proactive reassurance: "You are the only person I want. I'm going to prove that." If the behavior is compulsive (pornography addiction), honesty about the issue and willingness to seek help. |
| **Recommended Message Tone** | Accountable, empathetic, choosing-her |
| **Sample Message** | "I understand why this hurts you, and I'm not going to explain it away. How you feel matters more than any habit of mine. I'm unfollowing them right now, not because you're forcing me, but because you're the only person I want to make feel desired. I'm sorry I made you question that." |
| **Action Card Suggestion** | **SAY:** "You are enough. You have always been enough. I'm sorry I made you doubt that." **DO:** Unfollow/remove the content immediately. Increase genuine, specific compliments and physical affection toward her. **BUY:** Not applicable -- this requires behavioral change, not gifts. **GO:** To a place that is meaningful to your relationship -- recreate a special date, remind her why you chose each other. |
| **Escalation Trigger** | If this is part of a pattern of emotional betrayals, or if his behavior involves actual contact with other women, sexting, or infidelity -- Severity 4-5. Couples counseling or individual therapy for compulsive behavior. If her self-esteem damage becomes severe (disordered eating, self-harm, depression) -- professional support for her. |
| **Cultural Variations** | **Western:** Social media boundaries in relationships are actively debated. She may have specific expectations about what is acceptable. He should engage with her boundaries rather than dismissing them. **Arabic:** Looking at other women (in person or online) is both culturally and religiously discouraged. He is expected to "lower his gaze." Her hurt has cultural and religious validation. He should acknowledge this fully. **Malay:** Similar to Arabic. Modesty and fidelity expectations apply to online behavior. His actions online reflect on the marriage and the family's honor. |

---

## S035: She Is Experiencing Burnout and Cannot Function

| Field | Detail |
|-------|--------|
| **Situation ID** | S035 |
| **Category** | Emotional Crisis |
| **Situation** | She has been running at full capacity for too long -- work, home, children, family obligations, emotional labor -- and she has hit a wall. She may be unable to get out of bed, unable to make decisions, emotionally numb, or breaking down over minor things. This is not laziness; this is a system crash. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Empty. Not sad, not angry -- depleted. She has given everything and has nothing left. She may feel guilty about her inability to function, which compounds the exhaustion. She may feel invisible: all the things she held together are only noticed now that she has dropped them. She needs rescue, not advice. |
| **What He Thinks He Should Do** | Tell her to take a day off. Suggest a vacation. Express frustration that things are falling apart. List all the things that are not getting done. |
| **What She Actually Needs** | Total takeover. He needs to step in and handle everything -- or organize help for everything -- without complaint and without her having to direct it. She needs permission to completely stop functioning for as long as she needs. No guilt, no timeline, no "but what about..." She needs to hear: "You have carried more than anyone should. It's my turn now. You rest." Professional support if burnout has tipped into depression. |
| **Recommended Message Tone** | Protective, action-taking, zero-demand |
| **Sample Message** | "I can see you've been carrying the world, and today it's too heavy. I'm taking everything off your plate. You don't need to plan, decide, cook, clean, or manage anything. I've got it. Your only job today is to rest. Tomorrow too, if you need it." |
| **Action Card Suggestion** | **SAY:** "You don't have to be strong today. I'm your backup, and I'm stepping in." **DO:** Handle all household, childcare, and logistical responsibilities. Do not ask her to direct or manage you -- figure it out. **BUY:** A meal delivery subscription. A house cleaning service. Whatever removes burden. **GO:** Nowhere for her unless she chooses to. He should take the children out of the house to give her silence. |
| **Escalation Trigger** | If burnout persists beyond 2 weeks, if she shows signs of clinical depression (persistent emptiness, self-harm thoughts, inability to function even with support), or if she expresses hopelessness about ever recovering -- professional intervention is needed. Severity 4. |
| **Cultural Variations** | **Western:** Burnout is increasingly recognized. He can name it: "I think you're burned out, and I want to help." Professional help is normalized. **Arabic:** She may resist admitting burnout because the cultural expectation of female endurance is strong. He should act rather than label: "I'm handling things this week" is better than "I think you have burnout." Involve her mother or sisters if they are supportive -- communal care is culturally appropriate. **Malay:** Similar to Arabic. "Sabar" culture may prevent her from acknowledging burnout. He should observe and act. Involve family support if appropriate. Traditional rest and care practices can be helpful. |

---

# Category 5: Daily Mood Situations

> **Cross-reference:** LOLO-PSY-001, Section 6 (Emotional Temperature Model -- 10-State System)

---

## S036: She Had a Great Day and Wants to Share

| Field | Detail |
|-------|--------|
| **Situation ID** | S036 |
| **Category** | Daily Mood |
| **Situation** | She is bursting with positive energy -- she got a promotion, aced a presentation, had a wonderful time with friends, or simply had one of those days where everything clicked. She wants to share her joy with him. |
| **Severity** | 1 (Mild -- positive) |
| **Her Likely Emotional State** | Joyful, proud, and wanting to be celebrated. She is bringing her best moment to the person who matters most. How he responds to her good news is one of the strongest predictors of relationship satisfaction (Gable et al., 2004 -- "Active Constructive Responding"). If he is dismissive, distracted, or muted, it is more damaging than if he responds poorly to her bad news. |
| **What He Thinks He Should Do** | Say "That's great" while looking at his phone. Pivot to his own day. One-up her achievement. Bring up a practical concern ("That's great about the promotion, but will it mean longer hours?"). |
| **What She Actually Needs** | Enthusiastic, engaged celebration. Eye contact. Questions that show genuine interest: "Tell me everything. How did it happen? How do you feel?" Energy that matches hers. This is an investment moment -- his enthusiasm deposits into the relationship account. He should delay sharing his own news until she feels fully heard. |
| **Recommended Message Tone** | Enthusiastic, celebratory, genuinely interested |
| **Sample Message** | "That is AMAZING. I am so proud of you. Tell me everything -- every detail. I want to hear it all. You deserve this, and I'm so happy for you." |
| **Action Card Suggestion** | **SAY:** "You're incredible. I always knew this was coming." **DO:** Put your phone down. Make eye contact. Ask follow-up questions. Suggest celebrating. **BUY:** A small celebration -- her favorite dessert, a bottle of wine, flowers. **GO:** Take her out to celebrate. Dinner at a place she loves. Make it an event. |
| **Escalation Trigger** | None. This is a relationship-building moment. The only risk is failing to respond positively, which erodes trust over time. |
| **Cultural Variations** | **Western:** Open celebration is expected and welcomed. Public acknowledgment (social media post, telling friends) is appreciated. **Arabic:** He can celebrate with enthusiasm. Sharing her achievement with family shows pride. Be mindful of "evil eye" sensitivities -- she may prefer private celebration over public announcement. **Malay:** Celebration can be shared with family. Modesty may temper her self-expression, but she still needs his enthusiasm. A family dinner in her honor would be meaningful. |

---

## S037: She Is Exhausted After Work

| Field | Detail |
|-------|--------|
| **Situation ID** | S037 |
| **Category** | Daily Mood |
| **Situation** | She comes home drained. She may be quiet, go straight to change into comfortable clothes, or collapse on the couch. She does not want to talk about work, make decisions about dinner, or handle any household logistics. She needs decompression time. |
| **Severity** | 1 (Mild) |
| **Her Likely Emotional State** | Depleted but not distressed. She needs her battery to recharge. She may feel guilty about not being "on" when she gets home, especially if there are children or household tasks waiting. She wants to be left alone for a bit without it being interpreted as coldness or rejection. |
| **What He Thinks He Should Do** | Greet her with a list of things that need her attention. Ask "What's for dinner?" immediately. Take her quietness personally. Demand engagement. |
| **What She Actually Needs** | A decompression window of 20-30 minutes where no one needs anything from her. Dinner handled (or at least decided) before she walks in. A warm greeting that asks nothing: "Hey, I'm glad you're home. Dinner's almost ready. Take your time." Physical space or quiet affection, depending on her preference. |
| **Recommended Message Tone** | Low-demand, caring, practical |
| **Sample Message** | "I know today was long. Dinner's handled, and there's nothing you need to do tonight. Just relax. I'm glad you're home." |
| **Action Card Suggestion** | **SAY:** "Sit down. I've got everything. You don't have to do anything tonight." **DO:** Have dinner ready or ordered. Handle kid duties. Give her 30 minutes of quiet. **BUY:** Her favorite after-work comfort -- a specific tea, snack, or drink. **GO:** Nowhere unless she suggests it. Low-key evening at home. |
| **Escalation Trigger** | If work exhaustion is chronic and she is never recovering, flag for burnout (see S035). If she is also emotionally distressed (not just tired but despairing), dig deeper. |
| **Cultural Variations** | **Western:** Decompression time is a recognized need. He should provide it without taking it personally. **Arabic:** If she is a working woman, her home duties may still be expected after work. He should actively reduce this burden, especially on hard days. **Malay:** Similar -- she may come home to family obligations. He can help by managing the household or children while she recovers. |

---

## S038: She Is Lonely (He Has Been Busy or Traveling)

| Field | Detail |
|-------|--------|
| **Situation ID** | S038 |
| **Category** | Daily Mood |
| **Situation** | He has been consumed with work, travel, friends, or hobbies and she is feeling disconnected. She may not say "I'm lonely" directly -- it may come out as complaints about his schedule, increased messaging frequency, irritability, or sadness. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Longing for connection and feeling deprioritized. She may be constructing a narrative that he does not value time with her as much as time with other things. Loneliness in a relationship is more painful than loneliness when single because it carries the added weight of "I'm with someone and still alone." She needs quality attention, not just physical presence. |
| **What He Thinks He Should Do** | Point out that he has been busy with important things. Offer a rain check ("We'll do something this weekend"). Minimize her feelings ("I'm right here"). Send sporadic, low-effort texts and consider that sufficient. |
| **What She Actually Needs** | Prioritized, intentional time together. Not time in the same room staring at phones -- genuine, focused connection. A call when he is traveling: "I miss you. Tell me about your day." A planned date when he returns. Acknowledgment: "I know I've been absent, and I miss being close to you." Actions that prove she is a priority, not an afterthought. |
| **Recommended Message Tone** | Warm, missing-her, prioritizing |
| **Sample Message** | "I've been too caught up in everything else, and I feel it -- I miss you. You're the most important person in my life, and I haven't been showing it. Can we do something together this weekend? Just us. No phones, no agenda." |
| **Action Card Suggestion** | **SAY:** "I miss us. Let's fix that." **DO:** Plan a dedicated date or quality time block. Put the phone away. Make eye contact. Ask her real questions. **BUY:** Flowers or her favorite treat -- a "thinking of you" gesture. **GO:** Somewhere meaningful to the relationship -- where you had your first date, a favorite restaurant, a new place she mentioned. |
| **Escalation Trigger** | If loneliness is chronic and she has expressed it repeatedly without change, the relationship is eroding. If she has begun to emotionally withdraw or seek connection elsewhere, urgency increases. Severity 3-4 if persistent. |
| **Cultural Variations** | **Western:** She may articulate loneliness directly. He should receive it without defensiveness. **Arabic:** His absence for work or social obligations may be culturally expected, but her emotional needs still matter. He should ensure she has her own social support (female family and friends) and still prioritize couple connection. **Malay:** "Rindu" (longing/missing) is a core emotional concept. She may express it subtly. He should respond to rindu with warmth and prioritized presence. |

---

## S039: She Is Anxious About Something Specific

| Field | Detail |
|-------|--------|
| **Situation ID** | S039 |
| **Category** | Daily Mood |
| **Situation** | She has a specific source of anxiety: an upcoming medical test, a difficult conversation she needs to have, a deadline, a social event she is dreading, or a decision she must make. Her anxiety is focused and consuming. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Mind racing, stomach tight, difficulty concentrating on anything else. She may be playing out worst-case scenarios repeatedly. She wants the anxiety to stop but cannot logic her way out of it. She may seek reassurance, then dismiss the reassurance, then seek it again -- this is the anxiety loop. She needs grounding, not dismissal. |
| **What He Thinks He Should Do** | Solve it. Tell her not to worry. Provide logical arguments for why it will be fine. Get impatient with her repetitive worry. |
| **What She Actually Needs** | Grounding presence. Acknowledge the anxiety without feeding it: "I can see this is really weighing on you." Help her come back to the present: "Right now, right here, what is true?" Practical help if possible: "Want me to come with you?" or "Let me help you prepare." Physical comfort -- hand-holding, a hug -- activates the parasympathetic nervous system and genuinely reduces anxiety. |
| **Recommended Message Tone** | Calm, steady, grounding |
| **Sample Message** | "I can hear how anxious you are, and I understand why. I'm not going to tell you not to worry because I know it's not that simple. But I'm here. Whatever happens, we handle it together. And right now, can I just hold you for a minute?" |
| **Action Card Suggestion** | **SAY:** "I'm here, and whatever happens, we'll face it together." **DO:** Offer to accompany her. Help her prepare. Hold her hand. Suggest a grounding activity: a walk, deep breathing together, cooking together. **BUY:** Her comfort item -- a specific tea, a scented candle, something calming. **GO:** With her. Wherever the anxiety-source is, go together if possible. |
| **Escalation Trigger** | If anxiety is persistent, generalized (not situation-specific), or includes panic attacks, suggest professional support. If anxiety prevents her from functioning (missing work, avoiding essential tasks, not sleeping), Severity 3-4. |
| **Cultural Variations** | **Western:** She may be able to name her anxiety explicitly. He can engage directly. **Arabic:** Spiritual comfort (du'a, remembrance of Allah, Quran recitation) may be deeply calming. He can suggest praying together. **Malay:** Similar spiritual comfort applies. He can also suggest practical and spiritual preparation together. |

---

## S040: She Is in a Fun, Playful Mood

| Field | Detail |
|-------|--------|
| **Situation ID** | S040 |
| **Category** | Daily Mood |
| **Situation** | She is light, giggly, flirtatious, making jokes, or being silly. She wants to play, not process. She may initiate tickling, inside jokes, teasing, or spontaneous plans. |
| **Severity** | 1 (Mild -- positive) |
| **Her Likely Emotional State** | Open, carefree, and connected. This mood may occur during the follicular or ovulatory phase, or simply on a good day. She is reaching for lightness and wants him to meet her there. If he is too serious, too tired, or too distracted to engage, she will internalize it as rejection of her truest, most open self. |
| **What He Thinks He Should Do** | Be too tired or preoccupied to engage. Bring up something serious. Respond with flat energy. Miss the window entirely. |
| **What She Actually Needs** | Energy matching. Be silly with her. Laugh. Flirt. Play. This is relationship nourishment -- fun is not trivial; it is foundational. These moments build the positive reservoir that sustains the relationship through hard times. Drop whatever is on his mind and enter her energy. |
| **Recommended Message Tone** | Playful, flirtatious, high-energy |
| **Sample Message** | "I love this side of you. You make everything more fun. What trouble are we getting into tonight?" |
| **Action Card Suggestion** | **SAY:** Something playful and flirtatious. Match her energy. **DO:** Put the phone down. Engage physically -- tickle fight, dance in the kitchen, be spontaneous. **BUY:** Something fun and impulsive -- ice cream, a game, tickets to something last-minute. **GO:** Somewhere spontaneous and fun. A drive, a walk, a new spot she mentioned, anywhere that feeds the energy. |
| **Escalation Trigger** | None. Protect this mood. Do not waste it. |
| **Cultural Variations** | **Western:** Playfulness and spontaneity are valued relationship behaviors. Let it flow. **Arabic:** Playfulness within the private couple space is beautiful and Islamically encouraged (the Prophet's relationship with Aisha included playfulness and racing). Keep it private but fully engaged. **Malay:** "Manja" (affectionate playfulness) is deeply valued. He should reciprocate wholeheartedly. This builds the warmth that sustains the relationship. |

---

## S041: She Needs Quiet Time Alone

| Field | Detail |
|-------|--------|
| **Situation ID** | S041 |
| **Category** | Daily Mood |
| **Situation** | She has asked for alone time, or her behavior signals she needs it -- headphones in, book open, doors closed, retreating to a separate room. She is not angry; she is recharging. |
| **Severity** | 1 (Mild) |
| **Her Likely Emotional State** | Not distressed -- depleted. She needs to refill her emotional tank through solitude. This is especially common for introverts, during the luteal phase, or after a socially demanding period. Her request for space is not rejection -- it is self-care that makes her a better partner when she re-engages. |
| **What He Thinks He Should Do** | Take it personally. Hover. Check on her repeatedly. Fill the silence with conversation. Feel rejected and withdraw in retaliation. |
| **What She Actually Needs** | Gracious, complete space. No guilt-tripping. No checking in every 10 minutes. A simple "Enjoy your time. I'm here if you need me" and then genuine respect for the boundary. When she re-emerges, welcome her warmly without passive-aggressive comments about her absence. |
| **Recommended Message Tone** | Respectful, easy, brief |
| **Sample Message** | "Take all the time you need. I'll be here whenever you're ready. Enjoy the quiet." |
| **Action Card Suggestion** | **SAY:** "I want you to have this time. No guilt." **DO:** Give her the house or the room. Handle anything that might interrupt her. Do not text her during her alone time. **BUY:** Leave her favorite drink or snack near her space. **GO:** If the house is small, take yourself out for a bit. Give her the physical space. |
| **Escalation Trigger** | If she is always choosing alone time and never wanting togetherness, the emotional distance may be a symptom of a deeper issue. If "alone time" is actually isolation driven by depression, dig deeper. |
| **Cultural Variations** | **Western:** Alone time is a recognized need. Most couples negotiate this. **Arabic:** In communal living environments, alone time may be harder to achieve. He should actively create it for her -- take the children, manage visitors, give her a room. **Malay:** Similar -- communal family environments may make solitude rare. He should protect her right to recharge. |

---

## S042: She Wants Quality Time Together

| Field | Detail |
|-------|--------|
| **Situation ID** | S042 |
| **Category** | Daily Mood |
| **Situation** | She is craving focused, undivided togetherness. Not watching TV side by side -- real connection. She may suggest a date, a conversation, a walk, or simply say "Can we just... be together tonight?" |
| **Severity** | 1 (Mild -- positive) |
| **Her Likely Emotional State** | Open, tender, and reaching for intimacy. She is making a bid for connection (Gottman's concept). This is one of the most important moments in any relationship -- she is saying "I want YOU." If he turns toward this bid, the relationship strengthens. If he turns away (distraction, phone, indifference), a small crack forms. |
| **What He Thinks He Should Do** | Agree while staying on his phone. Suggest watching something. Be physically present but mentally elsewhere. Cancel because something else came up. |
| **What She Actually Needs** | Full presence. Phone down, off, or in another room. Eye contact. Real conversation -- not logistics, not planning, but "How are you? What's on your heart?" Physical closeness. The feeling that she is the most important thing in his world for this window of time. |
| **Recommended Message Tone** | Present, warm, focused |
| **Sample Message** | "I love that you want that, and I want it too. Tonight is just us. Phones off, nowhere to be. What do you want to do? Or do you just want to talk?" |
| **Action Card Suggestion** | **SAY:** "You have my complete attention. I'm all yours." **DO:** Put the phone away. Make eye contact. Ask her real questions. Listen. Create a space free of distraction. **BUY:** Cook dinner together. Light candles. Make the environment special. **GO:** A walk together. A quiet spot. Anywhere that facilitates conversation and closeness. |
| **Escalation Trigger** | None for the situation itself. But if she is repeatedly requesting quality time and he consistently fails to deliver, resentment builds. Monitor the pattern. |
| **Cultural Variations** | **Western:** "Date night" is a recognized relationship practice. He should protect it. **Arabic:** Couple time may occur within the family home setting. He can create private moments within the communal structure -- a quiet conversation after the children sleep, a walk together. **Malay:** Similar -- quality time may be carved from the communal family environment. A quiet evening together, even at home, is valuable. |

---

## S043: She Is Feeling Nostalgic or Sentimental

| Field | Detail |
|-------|--------|
| **Situation ID** | S043 |
| **Category** | Daily Mood |
| **Situation** | She is looking at old photos, mentioning memories, referencing the early days of the relationship, or feeling emotional about the passage of time. She may say things like "Remember when..." or "I miss how things used to be." |
| **Severity** | 1 (Mild) |
| **Her Likely Emotional State** | Tender and reflective. Nostalgia is a blend of warmth and gentle sadness -- she is cherishing what was and may be quietly mourning its passage. She is not necessarily criticizing the present; she is honoring the past and hoping the best of it still lives in the relationship. She wants him to share the memory and the feeling. |
| **What He Thinks He Should Do** | Dismiss it: "That was a long time ago." Not engage: "Hmm, yeah." Interpret it as criticism: "Are you saying things are worse now?" |
| **What She Actually Needs** | Enthusiastic engagement with the memory. "I remember that night. You wore that blue dress and I couldn't stop staring at you." Shared sentimentality: "Those were good times. And we still have good times ahead." A gesture that connects past and present: recreate an early-relationship experience, revisit a meaningful place, or reference a shared memory in a love note. |
| **Recommended Message Tone** | Warm, sentimental, memory-sharing |
| **Sample Message** | "I love that you remember those things. I do too. Remember [specific shared memory]? That's one of my favorite moments with you. And honestly? I think the best is still coming for us." |
| **Action Card Suggestion** | **SAY:** Share your own favorite memory of the relationship. Be specific and emotional. **DO:** Pull out old photos together. Plan a trip or date that recreates an early memory. Write her a note referencing a shared moment. **BUY:** A photo book, a framed picture from a meaningful moment, or a recreation of a gift from early in the relationship. **GO:** Back to where you had your first date, your favorite vacation spot, or a place that holds shared meaning. |
| **Escalation Trigger** | If nostalgia is persistent and tinged with grief ("Things were so much better then"), it may signal current relationship dissatisfaction. Explore what she feels is missing now. If she is mourning the relationship she once had, this may require deeper conversation or counseling. Severity 2-3 if persistent. |
| **Cultural Variations** | **Western:** Nostalgia in relationships is a common and healthy behavior. Engage fully. **Arabic:** Shared memories of courtship and early marriage are cherished. He can honor them by recreating meaningful gestures. **Malay:** "Rindu" (longing) for past shared moments is deeply felt. He should validate and share the feeling. |

---

# Category 6: Relationship Milestone Situations

> **Cross-reference:** LOLO-PSY-001, Section 6 (Emotional Temperature Model), Section 7 (Cross-Cultural Psychology)

---

## S044: First Anniversary Approaching

| Field | Detail |
|-------|--------|
| **Situation ID** | S044 |
| **Category** | Relationship Milestone |
| **Situation** | Their first anniversary (dating or marriage) is approaching. She is likely anticipating a meaningful acknowledgment. She may be planning something herself and hoping he is too. |
| **Severity** | 1 (Mild -- positive, but high-stakes for expectations) |
| **Her Likely Emotional State** | Hopeful and evaluative. The first anniversary is a marker -- it tells her how much he values the relationship going forward. She is comparing his effort to her expectations and to what she has seen from others. She may be excited, nervous, or testing whether he remembers without being reminded. Forgetting or underdelivering is interpreted as "I'm not important enough to remember." |
| **What He Thinks He Should Do** | A last-minute restaurant reservation. A generic card. Forget entirely and scramble to recover. Think his presence is the gift. |
| **What She Actually Needs** | Evidence that he planned ahead and thought about it. The effort matters more than the price. A heartfelt letter referencing specific moments from their first year. A plan that shows he knows her -- not a generic "nice dinner" but something tailored to her preferences and their shared history. He should make her feel that this milestone matters to him as much as it does to her. |
| **Recommended Message Tone** | Celebratory, reflective, committed |
| **Sample Message** | "One year with you, and I'm more certain than ever that you're my person. I've been planning something because this day matters to me as much as it does to you. Thank you for the best year of my life." |
| **Action Card Suggestion** | **SAY:** "This year with you has been the best of my life. Here's to many more." **DO:** Plan ahead -- a minimum of one week. Write a letter. Plan an experience she will love. **BUY:** A meaningful gift, not expensive necessarily but thoughtful. Something that references a shared memory or an inside joke. **GO:** Somewhere significant -- where you first met, first dated, or a new place she has mentioned wanting to visit. |
| **Escalation Trigger** | None unless he completely forgets, in which case the repair must be immediate, genuine, and substantial. A forgotten anniversary is a Severity 3 emotional event for her. |
| **Cultural Variations** | **Western:** Anniversary celebration is a strong cultural expectation. Social media documentation is common. **Arabic:** Wedding anniversaries (Hijri or Gregorian) may be celebrated differently. The gesture matters more than the date precision. A family-inclusive celebration or a private intimate one -- follow her preference. **Malay:** Anniversary celebrations are meaningful. He can plan something that blends romance with family acknowledgment if culturally appropriate. |

---

## S045: She Is Dropping Hints About Engagement

| Field | Detail |
|-------|--------|
| **Situation ID** | S045 |
| **Category** | Relationship Milestone |
| **Situation** | She has been mentioning friends' engagements, pausing at jewelry stores, sharing ring-related content on social media, asking about "the future," or making direct comments like "I wonder what my ring would look like." She wants a commitment and is signaling it. |
| **Severity** | 2 (Moderate -- emotionally loaded) |
| **Her Likely Emotional State** | Hopeful but vulnerable. Every hint is a risk -- she is exposing her desire and hoping it will be met. If he ignores the hints, she feels rejected and foolish for wanting. If he dismisses them ("Why are you in such a rush?"), it is devastating. She may be experiencing social pressure from friends and family who are getting engaged, which compounds her anxiety. She is not being "pushy" -- she is being brave about what she wants. |
| **What He Thinks He Should Do** | Ignore the hints. Get annoyed at the "pressure." Make jokes about avoiding commitment. Say "Eventually" without specificity. |
| **What She Actually Needs** | Honest, direct communication about where he stands. If he is planning a proposal, he should give her enough reassurance to calm the anxiety without spoiling the surprise: "Our future together is something I think about a lot. Trust me." If he is not ready, he owes her honest timing: "I love you and I see a future with us. I'm not there yet, but I want to be -- can we talk about what we both want?" Never leave her guessing about whether he wants a future with her. |
| **Recommended Message Tone** | Honest, reassuring, future-affirming |
| **Sample Message** | "I see you. I hear you. And I want you to know -- a future with you is not something I take lightly. It's something I think about seriously. I'm not going to spoil anything, but I need you to know: you're it for me." |
| **Action Card Suggestion** | **SAY:** "Our future matters to me as much as it does to you. I promise I'm thinking about it." **DO:** If planning a proposal, give subtle reassurance. If not ready, have an honest conversation about timelines and expectations. **BUY:** Not a ring yet (unless ready), but meaningful commitment gestures -- a piece of jewelry, a shared experience, something that says "I'm invested." **GO:** On a meaningful trip or experience that demonstrates long-term thinking. |
| **Escalation Trigger** | If she has been hinting for a prolonged period (6+ months) with no clear response, her frustration may escalate to relationship-questioning (see S033). She deserves clarity. If he is stringing her along with no intention of commitment, the AI must not enable that pattern. Severity 3 if she begins expressing despair about the future. |
| **Cultural Variations** | **Western:** Engagement discussions are direct and expected. She may want input on the ring, the timing, and the proposal style. **Arabic:** Marriage proposals often involve family negotiation and formal processes. He should be aware of and respect these protocols. Her hints may be directed at starting the family-level conversation. He should initiate discussions with her family if he is serious. **Malay:** Similar to Arabic -- family involvement in engagement is expected and valued. He should understand the traditional process ("merisik," the formal inquiry) and respect it. |

---

## S046: Moving in Together Stress

| Field | Detail |
|-------|--------|
| **Situation ID** | S046 |
| **Category** | Relationship Milestone |
| **Situation** | They are merging households. Disagreements about space, decor, habits, finances, and boundaries are surfacing. She may feel that her identity is being subsumed into "his space" or that her preferences are not being considered. The logistics are stressful, and the emotional stakes are high. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Excited but anxious. She is surrendering a degree of independence and needs to feel that the new shared space is equally hers. Every decorating disagreement is a proxy for "Will my identity survive this merger?" She may feel that he is not compromising enough, or that he does not understand the emotional significance of building a home together versus just having a roommate. |
| **What He Thinks He Should Do** | Focus on logistics (furniture, bills) and ignore emotional dynamics. Insist on keeping his existing setup. Dismiss her preferences as "too much." Rush the process. |
| **What She Actually Needs** | Equal voice in every decision about the shared space. Compromise that is visible and genuine. Recognition that building a home together is an emotional act, not just a logistical one. Patience with her feelings about the transition. Proactive inclusion: "What do you want this space to feel like? Let's build it together." |
| **Recommended Message Tone** | Collaborative, equal, future-building |
| **Sample Message** | "This is OUR home now, and I want it to feel like both of us. What's most important to you about how we set this up? I want this place to feel like home for you, not like you're just moving into my space." |
| **Action Card Suggestion** | **SAY:** "Your comfort and your style matter to me. This is ours." **DO:** Actively compromise -- let her choose the bedroom layout, the kitchen organization, the living room feel. Clear space for her belongings. **BUY:** Something for the new space that she loves -- a piece of art, a plant, new bedding she chose. **GO:** Shopping together for home items. Make it a fun, shared activity. |
| **Escalation Trigger** | If moving-in stress reveals fundamental incompatibilities (different cleanliness standards, financial disagreements, boundary violations), these need to be addressed before they calcify. Couples counseling may help with the transition. Severity 2-3. |
| **Cultural Variations** | **Western:** Cohabitation before marriage is common and the negotiation is expected. **Arabic:** Living together typically occurs after marriage. The new marital home is a significant investment. Her family may have expectations about the home's quality. He should ensure the home meets both their preferences and cultural expectations. **Malay:** Similar to Arabic -- cohabitation follows marriage. The marital home carries deep cultural significance. Both families may have input. He should balance family expectations with her personal preferences. |

---

## S047: Meeting Each Other's Families

| Field | Detail |
|-------|--------|
| **Situation ID** | S047 |
| **Category** | Relationship Milestone |
| **Situation** | She is meeting his family for the first time, or he is meeting hers. She is nervous about making a good impression and anxious about how the families will perceive the relationship. If meeting HIS family, she fears not being "good enough." If he is meeting HERS, she is anxious about his behavior and her family's judgment. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Anxious, self-conscious, and hypervigilant. She wants to be accepted and fears rejection. She may spend hours preparing -- outfit, hair, gifts -- and still feel inadequate. She needs him to be her anchor: visibly proud of her, supportive, and protective if any family member is unwelcoming. She is evaluating how he behaves around his family -- this is data about who he truly is. |
| **What He Thinks He Should Do** | Throw her into the deep end ("Just be yourself, they'll love you"). Not prepare her for family dynamics. Side with his family if there is any tension. Not notice her discomfort. |
| **What She Actually Needs** | Thorough preparation: who will be there, what to expect, any topics to avoid, what his family values. Visible partnership during the event: he stays near her, includes her in conversations, and shows pride in introducing her. Protection: if a family member says something hurtful, he addresses it (privately or in the moment, depending on severity). Debriefing after: "You were amazing. My family loved you -- and even if they didn't, my choice is clear." |
| **Recommended Message Tone** | Reassuring, proud, protective |
| **Sample Message** | "I know meeting my family is a big deal, and I want you to know: they're going to love you because I love you. But even if someone says something weird -- families can be weird -- I'm on your team. Always. I'm going to be right beside you the entire time." |
| **Action Card Suggestion** | **SAY:** "I'm proud to introduce you. You're the best thing in my life, and they're going to see why." **DO:** Stay physically close during the gathering. Include her in conversations. Brief her on family dynamics in advance. **BUY:** Help her choose or bring a gift for his family if culturally appropriate. **GO:** Together. Arrive together, leave together. She should never feel alone in a room of his relatives. |
| **Escalation Trigger** | If family rejection is severe or if his family's treatment of her is consistently hostile, this becomes a Severity 3-4 situation requiring clear boundary-setting from him. His loyalty to her must be unambiguous. |
| **Cultural Variations** | **Western:** Family meetings are significant but generally informal. She may worry about being liked but not about formal approval. **Arabic:** Family approval is often essential for the relationship's future. The meeting may be formal and involve both sets of parents. Cultural expectations about dress, behavior, and conversation are specific. He should prepare her thoroughly and support her through the process. **Malay:** Meeting family is a structured, significant event. "Merisik" (formal family visit) has specific protocols. He should ensure she knows what to expect and feels supported throughout. |

---

## S048: Planning a Vacation Together

| Field | Detail |
|-------|--------|
| **Situation ID** | S048 |
| **Category** | Relationship Milestone |
| **Situation** | They are planning a trip together. Disagreements may arise about destination, budget, activities, and pace. She may want relaxation while he wants adventure, or vice versa. The planning process is a microcosm of how they make decisions together. |
| **Severity** | 1 (Mild) |
| **Her Likely Emotional State** | Excited but potentially frustrated if she feels her preferences are not being valued. Vacation planning is emotionally loaded because it represents how the couple prioritizes each other's happiness. If he railroads the decisions, she feels unheard. If he is passive and makes her plan everything, she feels the mental load extending even into leisure. |
| **What He Thinks He Should Do** | Defer entirely ("Whatever you want"). Or decide everything himself. Focus only on logistics and budget, ignoring the emotional experience she is imagining. |
| **What She Actually Needs** | Collaborative planning where both preferences are valued. He should take initiative on some elements (booking, research) so she is not carrying the entire planning burden. The emotional narrative matters: this is not a logistics exercise, it is "building a memory together." Show excitement about her ideas and integrate them with his. |
| **Recommended Message Tone** | Excited, collaborative, equal |
| **Sample Message** | "I've been looking at options for our trip, and I found a few that I think we'd both love. I want this to be perfect for both of us. Let's plan it together tonight -- I'll bring the laptop and the wine." |
| **Action Card Suggestion** | **SAY:** "I want this trip to be something we both remember forever. What matters most to you?" **DO:** Take initiative on booking and research. Surprise her with one element she will love. **BUY:** A travel guide for the destination, a new journal for the trip, or a travel item she needs. **GO:** On the trip you planned together, with enthusiasm and presence. |
| **Escalation Trigger** | If vacation planning reveals irreconcilable differences in values or priorities, take note. If every joint decision becomes a fight, couples communication skills need work. Severity 2. |
| **Cultural Variations** | **Western:** Couple vacations are standard. She may have specific expectations from travel influencer culture. **Arabic:** Travel may involve family or religious considerations (halal travel, prayer facilities, conservative destinations). He should plan with these in mind. **Malay:** Family obligations during holidays (balik kampung) may take priority over couple vacations. He should balance family expectations with couple time. |

---

## S049: A Special Birthday (30, 40, etc.)

| Field | Detail |
|-------|--------|
| **Situation ID** | S049 |
| **Category** | Relationship Milestone |
| **Situation** | She is approaching a milestone birthday. She may be excited, dreading it, or both. Milestone birthdays often trigger reflection on life progress, aging, achievement, and identity. She wants to feel celebrated and valued, not "old." |
| **Severity** | 2 (Moderate -- emotionally significant) |
| **Her Likely Emotional State** | Complex. She may feel grateful for life and simultaneously anxious about aging. She may evaluate her life against her expectations and feel she has fallen short -- or feel proud but unrecognized. She wants to be celebrated in a way that honors who she IS, not mourned for who she was. She does not want jokes about aging or getting old. She wants to feel that her partner sees her fully and celebrates her without condition. |
| **What He Thinks He Should Do** | A standard dinner out. An age-related joke ("Over the hill!"). A last-minute plan. A generic gift. |
| **What She Actually Needs** | A celebration that reflects genuine thought and knowledge of who she is. A heartfelt expression of what she means to him -- a letter, a speech, a toast. Planning that shows effort (not a scramble). Something that makes her feel beautiful, valued, and seen. If she is anxious about the age, reassurance that comes through action: "Every year with you gets better." |
| **Recommended Message Tone** | Celebratory, affirming, deeply personal |
| **Sample Message** | "This birthday is a big deal, and so are you. I've been thinking about what to say, and here it is: you are more beautiful, more brilliant, and more incredible with every year. I am the luckiest person alive to get to celebrate you. Happy birthday to the love of my life." |
| **Action Card Suggestion** | **SAY:** "You are better at [age] than anyone I know. I love who you are right now." **DO:** Plan ahead -- weeks, not days. Involve her closest friends if she would want that. Write a heartfelt letter. **BUY:** A meaningful gift -- not generic. Something that reflects her current passions, dreams, or identity. **GO:** Somewhere special. A restaurant she has been wanting to try, a trip, or an experience she has mentioned. |
| **Escalation Trigger** | If the milestone birthday triggers a depressive episode or existential crisis (severe dissatisfaction with life, hopelessness about the future), this may need deeper exploration. Severity 2-3 if mood does not lift after the birthday period. |
| **Cultural Variations** | **Western:** Milestone birthdays are major celebrations. Surprise parties, social media tributes, and significant gifts are common. **Arabic:** Birthday celebrations vary -- some observe them enthusiastically, some do not celebrate per religious preference. Follow her and her family's practice. If she celebrates, make it meaningful. If the family is religious and does not celebrate birthdays, find another way to honor her (a special gift or experience on a non-birthday occasion). **Malay:** Birthdays are generally celebrated. He can plan something that includes her family if she would enjoy that, or an intimate couple celebration. |

---

# Category 7: Family and Social Situations

> **Cross-reference:** LOLO-PSY-001, Section 5.2 (Family Conflict), Section 5.5 (Social/Friendship Stress), Section 7 (Cross-Cultural Psychology)

---

## S050: Conflict with Her Mother-in-Law

| Field | Detail |
|-------|--------|
| **Situation ID** | S050 |
| **Category** | Family & Social |
| **Situation** | She is in conflict with his mother. The conflict may be about boundaries, interference in the relationship, criticism of her cooking/housekeeping/parenting, favoritism toward other siblings' partners, or feeling that his mother does not accept her. This is one of the most common and most destructive relationship stressors globally. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Trapped, furious, and heartbroken. She loves him but feels that his mother is a permanent adversary. If he does not clearly side with her, she feels abandoned -- like she married his entire family and he will always choose them over her. She may feel inadequate (his mother's criticism hits at her identity as a wife and partner) and powerless (she cannot change the dynamic alone). The central question: "Will he protect me, or will he protect his mother's feelings at my expense?" |
| **What He Thinks He Should Do** | Mediate. Say "She means well." Defend his mother. Ask his wife to "just get along." Avoid the conversation entirely. |
| **What She Actually Needs** | Unambiguous loyalty. "You are my priority. If my mother is crossing a line, I will address it." Not mediation -- advocacy. He should set boundaries with his mother directly, without making his wife the villain ("Mom, I need you to respect our decisions as a couple"). He should never ask her to tolerate disrespect for the sake of family peace. He should validate her feelings without defending his mother in the same breath. |
| **Recommended Message Tone** | Loyal, clear, protective |
| **Sample Message** | "I hear you, and you're right. My mother crossed a line, and that's on me to fix -- not you. You should never feel like you come second. I'm going to talk to her, and I'm going to be clear. You're my partner, and protecting our relationship is my job." |
| **Action Card Suggestion** | **SAY:** "I'm on your side. Always. My mother needs to respect our boundaries, and I will make that clear." **DO:** Have the conversation with his mother directly. Do not make his wife be the one to set the boundary. **BUY:** Not applicable. **GO:** To a neutral space if the conflict happens during a family visit -- remove her from the situation calmly. |
| **Escalation Trigger** | If mother-in-law conflict is chronic and he consistently fails to set boundaries, the relationship may deteriorate to a crisis point. If his mother's behavior is emotionally abusive, stronger intervention is needed. If the conflict is causing her depression or anxiety, professional support is warranted. Severity 3-4. |
| **Cultural Variations** | **Western:** She may expect him to "choose" her explicitly. Boundary-setting with parents is culturally supported. **Arabic:** Mother-in-law dynamics are deeply culturally embedded. His mother may hold significant authority in the household. He must navigate with respect for his mother while protecting his wife -- this is a delicate but non-negotiable balance. He should never publicly shame his mother, but he must privately advocate for his wife. The AI should never suggest the wife simply "accept" mistreatment. **Malay:** Similar to Arabic. Respect for elders is paramount, but it does not override his wife's dignity. He can seek help from a respected elder who can mediate with cultural authority. |

---

## S051: Family Gathering She Is Dreading

| Field | Detail |
|-------|--------|
| **Situation ID** | S051 |
| **Category** | Family & Social |
| **Situation** | There is an upcoming family event (holiday dinner, wedding, reunion) that she is dreading. It may involve difficult relatives, social pressure, uncomfortable questions (about marriage, children, career), or a generally stressful environment. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Anxious and resentful. She may feel obligated to attend and perform happiness. She anticipates being scrutinized, questioned, or compared. She may dread specific people or specific topics. She wants an ally at the event -- someone who will protect her from uncomfortable situations, give her an excuse to leave if needed, and debrief with her afterward. |
| **What He Thinks He Should Do** | Tell her it will be fine. Minimize her concerns. Leave her to manage his family while he catches up with relatives. Not prepare for difficult questions. |
| **What She Actually Needs** | Pre-event strategy: discuss what she is dreading and plan together. "If Aunt X asks about babies, I'll redirect the conversation." A signal system: a word or touch that means "I need to leave" or "save me from this conversation." His active presence beside her -- not abandoned while he socializes separately. Post-event debriefing: "You were amazing. Thank you for doing that. Here's how I'm going to make it up to you." |
| **Recommended Message Tone** | Allied, strategic, protective |
| **Sample Message** | "I know this gathering is stressful for you, and I want us to go in as a team. Let's talk about what you're worried about, and I'll make sure I'm right there with you. And if at any point you want to leave, we leave. No questions asked." |
| **Action Card Suggestion** | **SAY:** "We're a team. I've got your back the entire time." **DO:** Stay physically near her during the event. Redirect uncomfortable conversations. Have a signal for "I need to go." **BUY:** A treat for after the event as a reward -- her favorite dessert, a movie she wants to watch, something to look forward to. **GO:** Together, stay together, leave together. |
| **Escalation Trigger** | If family events are consistently traumatic (not just stressful), explore whether there is a toxic family dynamic that may require therapeutic support or boundary-setting. Severity 2-3. |
| **Cultural Variations** | **Western:** She can decline attendance if the event is too stressful. Her autonomy to choose is supported. **Arabic:** Family gatherings are often obligatory. Declining may cause significant social repercussions. He should make the experience as bearable as possible rather than suggesting she skip it. **Malay:** Similar to Arabic -- family gatherings (especially during Hari Raya or other celebrations) are expected. He should be her shield within the gathering. |

---

## S052: Her Best Friend Is Going Through Something

| Field | Detail |
|-------|--------|
| **Situation ID** | S052 |
| **Category** | Family & Social |
| **Situation** | Her closest friend is experiencing a crisis -- a breakup, a diagnosis, a loss, or a difficult life event. She is emotionally invested in supporting her friend, which may mean late-night calls, canceled plans, emotional exhaustion, and distraction. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Empathetically distressed. Women's close friendships involve deep emotional identification -- her friend's pain is, to a meaningful degree, her pain. She may feel pulled between supporting her friend and maintaining her own life. She needs her partner to understand the depth of this bond and support her supporting her friend, without jealousy or resentment. |
| **What He Thinks He Should Do** | Get annoyed at the disruption. Say "It's not your problem." Resent the time she is giving her friend. Minimize the friendship: "She'll be fine." |
| **What She Actually Needs** | Support for her support role. "I can see how much this is affecting you. Your friendship with [name] is important, and I want to help. What do you need?" Practical help: take on more at home so she has the bandwidth to be there for her friend. Emotional patience: she may be more drained, distracted, or tearful. Do not compete with the friendship; complement it. |
| **Recommended Message Tone** | Understanding, supportive, team-oriented |
| **Sample Message** | "I can see how much [friend's name]'s situation is weighing on you. She's lucky to have you as a friend. I've got things covered here -- you focus on being there for her. And if you need to talk about it, I'm here too." |
| **Action Card Suggestion** | **SAY:** "Your friendships matter to me because they matter to you. How can I help?" **DO:** Handle household and responsibilities so she can devote time to her friend. Offer practical help for the friend too (a meal, a ride, a gesture). **BUY:** Something for the friend from both of them -- flowers, a care package. **GO:** Nowhere that takes her away from supporting her friend. If she wants company while processing, be present. |
| **Escalation Trigger** | If her friend's crisis triggers her own unresolved issues, or if the emotional weight becomes too much for her (she cannot sleep, cannot function, her own mood deteriorates significantly), suggest she talk to someone about the secondary trauma. Severity 2-3. |
| **Cultural Variations** | **Western:** Female friendships are recognized as essential. He should support without competing. **Arabic:** Female friendships are often intense and intimate. Her social world may revolve around close female bonds. He should respect and facilitate this. **Malay:** Female friendships are deeply valued. He should see her supporting her friend as an expression of her beautiful character, not a diversion of her attention from him. |

---

## S053: She Is Feeling Pressure About Having Children

| Field | Detail |
|-------|--------|
| **Situation ID** | S053 |
| **Category** | Family & Social |
| **Situation** | She is receiving pressure from family, friends, or society to have children -- or to have them sooner, have more, or have a specific gender. She may also be pressuring herself based on her biological clock, comparison with peers, or internalized expectations. She may or may not want children; either way, the pressure is unwelcome. |
| **Severity** | 3 (Significant) |
| **Her Likely Emotional State** | Pressured, invaded, and possibly ashamed. If she wants children but has not yet conceived, the pressure amplifies her grief and anxiety. If she does not want children, the pressure challenges her identity and choices. If they are struggling with fertility, the pressure is salt in an open wound. She needs her partner to be a unified front against external pressure and a safe space for her own feelings. |
| **What He Thinks He Should Do** | Add to the pressure ("My mom keeps asking too"). Dismiss her feelings ("Just ignore them"). Avoid the topic. Make it about his own preferences without considering hers. |
| **What She Actually Needs** | A united front: "This is our decision, and no one else's." Protection from external pressure: he should address his family's comments directly and shield her from repeated questioning. A safe space to explore her own feelings about children without judgment. If they are struggling with fertility, shared grief and shared hope. If they disagree about children, honest, respectful conversation. |
| **Recommended Message Tone** | Protective, united, validating |
| **Sample Message** | "I know the questions about kids are getting to you, and I want you to know: this is OUR decision, on OUR timeline. I'll handle my family -- you shouldn't have to defend our choices to anyone. How are you feeling about everything? I want to know what's in your heart." |
| **Action Card Suggestion** | **SAY:** "No one gets to pressure us about this. We decide together." **DO:** Directly address family members who are applying pressure. Never join in the questioning. **BUY:** Not applicable. **GO:** If the pressure is at a family gathering, be ready to redirect or exit the conversation. |
| **Escalation Trigger** | If the pressure triggers depression, anxiety, or relationship conflict about differing desires for children, couples counseling is recommended. If she is dealing with infertility, specialized fertility counseling or support groups may be needed. Severity 3-4 for fertility-related distress. |
| **Cultural Variations** | **Western:** Childfree choices are increasingly accepted but still questioned. He should support her choice without qualifiers. **Arabic:** Fertility and children are deeply valued in Islamic and Arab culture. Pressure from family is intense and persistent. He must protect her from shame while navigating cultural expectations respectfully. If there is a fertility issue, Islamic guidance (trusting Allah's will) can be a source of comfort alongside medical support. **Malay:** Similar to Arabic -- family pressure about children is strong. He should be her shield while respecting cultural values. Traditional remedies for fertility may be offered; he should support whatever approach she is comfortable with. |

---

## S054: Cultural or Religious Family Expectations

| Field | Detail |
|-------|--------|
| **Situation ID** | S054 |
| **Category** | Family & Social |
| **Situation** | She is navigating expectations from her or his family that are rooted in cultural or religious tradition -- expectations about dress, behavior, religious practice, social roles, food preparation, hosting duties, or deference to elders. She may agree with some and resist others. She may feel caught between modernity and tradition, or between pleasing family and being true to herself. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Torn. She may love her culture and feel burdened by it simultaneously. She may feel guilty for resisting expectations and resentful of being expected to comply. If the expectations come from HIS family's culture (in intercultural relationships), she may feel like a perpetual outsider. She needs her partner to be sensitive to her internal conflict without dismissing either the culture or her individuality. |
| **What He Thinks He Should Do** | Side with tradition ("That's just how our family does things"). Dismiss tradition ("Just ignore them"). Not acknowledge the tension at all. Force her to comply or refuse without exploring her own feelings. |
| **What She Actually Needs** | Acknowledgment of the tension: "I know you're caught between what's expected and what feels right for you. That must be really hard." Partnership in navigation: together, they can decide which traditions to honor and which to adapt. Protection from shaming: if family members criticize her for not meeting expectations, he must intervene. Respect for her autonomy: she gets to decide which elements of culture she embraces and which she does not. |
| **Recommended Message Tone** | Respectful, navigating, partnership-oriented |
| **Sample Message** | "I know family expectations can feel heavy, especially when they conflict with what you want. I want you to know: we navigate this together. What matters most is that you feel respected -- by my family, by yours, and especially by me. Tell me what's weighing on you." |
| **Action Card Suggestion** | **SAY:** "Our relationship comes first. We honor our families together, on our terms." **DO:** Have private conversations about which expectations to meet and which to push back on. Present a united front. **BUY:** Not applicable. **GO:** Together to family events, as a team with a shared strategy. |
| **Escalation Trigger** | If cultural expectations are being enforced through emotional abuse, manipulation, or coercion -- this is beyond cultural negotiation and may require professional support. If she is being isolated from her own cultural community, this is a red flag. Severity 3-4 for coercive dynamics. |
| **Cultural Variations** | **Western:** Intercultural couples may face conflicting norms. He should educate himself about her culture and demonstrate respect. **Arabic:** Cultural expectations are deeply embedded and family-reinforced. He should navigate them with respect while protecting her autonomy within the cultural framework. An imam or cultural counselor may help mediate. **Malay:** "Adat" (custom) carries significant weight. He should understand the expectations and help her navigate them. Traditional practices should be respected even if adapted. |

---

## S055: She Is Dealing with Social Media Comparison and Insecurity

| Field | Detail |
|-------|--------|
| **Situation ID** | S055 |
| **Category** | Family & Social |
| **Situation** | She is scrolling through social media and feeling inadequate -- other women seem more beautiful, their relationships seem better, their homes more perfect, their lives more curated. She may make comments like "Why can't we be like that?" or go quiet after scrolling. |
| **Severity** | 2 (Moderate) |
| **Her Likely Emotional State** | Inadequate, envious, and sad. She knows intellectually that social media is curated, but emotionally she is comparing her behind-the-scenes to everyone else's highlight reel. She may feel unattractive, under-romanced, or generally "not enough." This is one of the most pervasive emotional toxins in modern relationships. She needs her partner to be the antidote to the comparison, not another source of it. |
| **What He Thinks He Should Do** | Tell her social media is fake. Roll his eyes. Get annoyed: "Why do you care about that?" Ignore it. |
| **What She Actually Needs** | Validation of the feeling without enabling the comparison: "I understand why that's getting to you. It's designed to make you feel that way." Then: active countering through his behavior. "Our relationship isn't on Instagram, but it's real. And I'd choose real with you over curated with anyone." Consistent, genuine romantic effort that gives her nothing to envy in others. If she is willing: a conversation about reducing social media exposure for her mental health. |
| **Recommended Message Tone** | Grounding, affirming, real |
| **Sample Message** | "I know what you see online can make everything feel like it's not enough. But what we have -- the real, messy, beautiful thing we have -- is worth more than a thousand perfect posts. You are more than enough. And I'm going to keep proving that to you." |
| **Action Card Suggestion** | **SAY:** "Forget what's on those screens. What we have is real, and it's extraordinary." **DO:** Plan a romantic gesture that is not about social media but about genuine connection. Write her a love note. Create a moment worth remembering. **BUY:** Something that says "I pay attention to YOU, not the algorithm" -- her favorite flowers, a book she mentioned, a personal item. **GO:** Somewhere that creates a real memory -- a walk at sunset, a new restaurant, a place that matters to your story. |
| **Escalation Trigger** | If social media comparison is driving persistent low self-esteem, body image distress, or depressive symptoms, suggest a digital detox and/or therapy. If she develops compulsive scrolling patterns that worsen her mood, this is a mental health concern. Severity 2-3. |
| **Cultural Variations** | **Western:** Social media influence is most pervasive in Western contexts. The "Instagram relationship" ideal is particularly toxic. He should actively counter it. **Arabic:** Social media is heavily used in GCC countries. Curated luxury lifestyles can trigger intense comparison. He should reassure her that their relationship's value is not measured by visible displays. **Malay:** Social media comparison is growing. He should affirm their relationship's worth beyond what is visible online. |

---

# Appendix: Quick-Reference Matrix Summary

| ID | Category | Situation (Short) | Severity | Core Need | Lead Response |
|----|----------|-------------------|----------|-----------|---------------|
| S001 | Menstrual | Bad cramps | 2 | Physical comfort, reduced demands | DO: Acts of service |
| S002 | Menstrual | PMS mood swings | 2 | Patience, validation | SAY: Validate feelings |
| S003 | Menstrual | Unexplained irritability | 1 | Low-demand presence | DO: Reduce household demands |
| S004 | Menstrual | Heavy flow exhaustion | 2 | Total task takeover | DO: Handle everything |
| S005 | Menstrual | Bloated, feels unattractive | 2 | Specific compliments | SAY: Genuine affirmation |
| S006 | Menstrual | Wants intimacy during period | 1 | Responsive physical affection | DO: Follow her lead |
| S007 | Menstrual | Comfort food guilt | 1 | Zero judgment | BUY: Her comfort food |
| S008 | Menstrual | Snaps then feels guilty | 2 | Quick forgiveness | SAY: "We're okay" |
| S009 | Pregnancy | Morning sickness | 2 | Household takeover, empathy | DO: Manage all cooking/cleaning |
| S010 | Pregnancy | Anxiety about baby | 3 | Shared emotional weight | SAY: Validate fear, GO: Doctor together |
| S011 | Pregnancy | Body image changes | 2 | Expressions of desire | SAY: Specific attraction |
| S012 | Pregnancy | Nesting excitement | 1 | Active participation | DO: Build/prepare enthusiastically |
| S013 | Pregnancy | Third trimester discomfort | 2 | Maximum practical support | DO: Anticipate needs |
| S014 | Pregnancy | Birth plan stress | 2 | Engaged birth partner | DO: Read plan, attend classes |
| S015 | Pregnancy | He's not excited enough | 3 | Visible emotional investment | SAY: Talk to the baby, share feelings |
| S016 | Pregnancy | Terrified of labor | 3 | Validation and preparation | SAY: "I'll be right there" |
| S017 | Pregnancy | Bad prenatal news | 4 | Emotional presence first | DO: Hold her, no rushing |
| S018 | Postpartum | Sleep deprivation | 3 | Shared nighttime duties | DO: Take baby for sleep blocks |
| S019 | Postpartum | Body image post-birth | 2 | Present-tense affirmation | SAY: "Beautiful NOW" |
| S020 | Postpartum | Overwhelmed new mom | 3 | Active co-parenting | DO: Take baby for hours |
| S021 | Postpartum | Baby blues | 2 | Normalization, patience | SAY: "This is normal, I'm here" |
| S022 | Postpartum | PPD warning signs | 4 | Professional referral | DO: Make the appointment |
| S023 | Postpartum | Resents him | 3 | Acknowledgment + behavior change | SAY: "You're right" + DO: Step up |
| S024 | Crisis | He lied | 4 | Full accountability | SAY: "No excuses. I was wrong." |
| S025 | Crisis | Silent after argument | 3 | Space then humble repair | SAY: "I want to listen" |
| S026 | Crisis | Crying, won't say why | 2 | Quiet warm presence | DO: Sit with her silently |
| S027 | Crisis | Work stress | 2 | Listening, home relief | SAY: "You're brilliant" + DO: Handle dinner |
| S028 | Crisis | Death of loved one | 4 | Sustained presence | DO: Be there, handle logistics |
| S029 | Crisis | Feels taken for granted | 3 | Specific acknowledgment | SAY: Name what she does |
| S030 | Crisis | Thinks he's not attracted | 3 | Active desire expression | SAY: Specific desire |
| S031 | Crisis | Comparing to other couples | 2 | Curiosity about her needs | SAY: "What would make you feel special?" |
| S032 | Crisis | "I'm fine" (not fine) | 2 | Gentle persistence | DO: Stay present, make tea |
| S033 | Crisis | Questioning relationship | 4 | Serious engagement, therapy | DO: Book couples counseling |
| S034 | Crisis | Found him looking at others online | 3 | Accountability, choosing her | DO: Unfollow immediately |
| S035 | Crisis | Burnout / can't function | 3 | Total takeover | DO: Handle everything |
| S036 | Daily | Great day, wants to share | 1 | Enthusiastic celebration | SAY: "Tell me everything!" |
| S037 | Daily | Exhausted after work | 1 | Decompression time | DO: Have dinner ready |
| S038 | Daily | Lonely (he's been absent) | 2 | Prioritized quality time | GO: Plan a date |
| S039 | Daily | Anxious about something | 2 | Grounding presence | DO: Hold her hand, offer to help |
| S040 | Daily | Playful mood | 1 | Energy matching | DO: Be silly together |
| S041 | Daily | Needs alone time | 1 | Gracious space | DO: Give space without guilt |
| S042 | Daily | Wants quality time | 1 | Full presence | DO: Phone away, eye contact |
| S043 | Daily | Nostalgic/sentimental | 1 | Shared memory engagement | SAY: Share your favorite memory |
| S044 | Milestone | First anniversary | 1 | Planned, meaningful celebration | DO: Plan ahead, write a letter |
| S045 | Milestone | Hints about engagement | 2 | Honest future communication | SAY: Reassure about commitment |
| S046 | Milestone | Moving in together | 2 | Equal voice in decisions | DO: Compromise visibly |
| S047 | Milestone | Meeting families | 2 | Visible partnership and protection | DO: Stay beside her |
| S048 | Milestone | Planning vacation | 1 | Collaborative planning | DO: Take initiative, include her |
| S049 | Milestone | Milestone birthday | 2 | Thoughtful, personal celebration | DO: Plan weeks ahead |
| S050 | Family | Mother-in-law conflict | 3 | Unambiguous loyalty | SAY: "I'm on your side" |
| S051 | Family | Dreaded family gathering | 2 | Allied team strategy | DO: Stay near her, have exit plan |
| S052 | Family | Friend in crisis | 2 | Support her support role | DO: Handle home, give her bandwidth |
| S053 | Family | Pressure about children | 3 | United front | SAY: "Our decision, our timeline" |
| S054 | Family | Cultural expectations | 2 | Partnership in navigation | DO: Navigate together |
| S055 | Family | Social media comparison | 2 | Grounding and real romance | SAY: "What we have is real" |

---

# Document Control

| Item | Detail |
|------|--------|
| **Document ID** | LOLO-PSY-002 |
| **Version** | 1.0 |
| **Author** | Dr. Elena Vasquez, Women's Psychology Consultant |
| **Date** | 2026-02-14 |
| **Status** | Complete -- Ready for AI Engine Integration |
| **Dependencies** | LOLO-PSY-001 (Women's Emotional State Framework) |
| **Next Document** | LOLO-PSY-003 (Response Templates and Action Card Library) |
| **Review Cycle** | Quarterly, or upon addition of new supported cultures/languages |

---

> **Final Note from Dr. Vasquez:** This matrix is a living document. Real relationships produce situations not captured here. The AI engine must be trained to interpolate between these situations using the underlying principles: validate first, act second, never dismiss, never diagnose, always point toward professional help when severity warrants it. The goal is not to script a relationship -- it is to help a man become the partner she already hoped he would be.

---
