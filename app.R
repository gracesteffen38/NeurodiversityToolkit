library(shiny)

clusters <- list(
  
  "Being on time" = list(
    icon = "⏰",
    preview = c("I think I have more time than I do", "I can't make myself stop what I'm doing to leave"),
    statements = c(
      "I think I have more time than I do",
      "I check the clock and think I'm fine, then suddenly I'm late",
      "I can't tell the difference between how 10 minutes feels vs. 30 minutes",
      "I lose track of time completely when I'm doing something",
      "I know what time I need to leave but I don't automatically figure out when to start getting ready",
      "I can't make myself stop what I'm doing even when I know I need to leave",
      "I tell myself 'five more minutes' and then it's been 45 minutes",
      "I underestimate how long getting ready actually takes",
      "I forget to count all the small steps — finding my keys, eating, walking to the bus",
      "I plan for the ideal version of getting ready, not the realistic version",
      "I feel resistance or dread about leaving even when I'm not running late",
      "I delay leaving because I don't feel mentally ready yet",
      "I get stuck checking things over and over before I can go",
      "I'd rather rush than wait somewhere early"
    ),
    causes = list(
      "Difficulty sensing time passing" = list(
        plain = "Some people's brains don't register time the same way — 20 minutes and 2 hours can feel identical. This isn't a character flaw, it's a cognitive difference.",
        label = "Time blindness",
        strategies = c(
          "Set an alarm called 'LEAVE NOW' — remove the need to calculate anything",
          "Use a visual timer (like a Time Timer app) so time passing is something you can see, not just a number",
          "Put a clock somewhere you'll actually look — inside the shower, on your bedroom ceiling, on your laptop taskbar",
          "Practice 'time audits': guess how long a task will take, then time it, to build a more accurate internal clock",
          "Create a 'leaving the house' time 15 minutes earlier than you actually need to leave, and treat that as the real deadline",
          "Set your phone wallpaper or a sticky note with what time you need to leave today",
          "Start a navigation app while you get ready so you can see what time you would arrive if you left immediately"
        )
      ),
      "Difficulty switching tasks" = list(
        plain = "Stopping one thing to do another requires a cognitive 'gear shift' that some brains resist strongly. It's not laziness — it's a real friction point.",
        label = "Task switching",
        strategies = c(
          "Set a 'wrap up' alarm 15–20 minutes before you need to leave — not to leave, but to start finishing",
          "Use a physical cue to signal the switch: stand up, say 'stopping now,' close your laptop — make it a concrete action",
          "Write down exactly where you stopped and what the next step is, so it feels safe to walk away",
          "Negotiate with yourself: 'I'll stop at the next natural pause' rather than trying to stop immediately",
          "Try body doubling — have someone nearby who's also packing up to leave",
          "Use an app like Freedom to automatically block distractions 20 minutes before you need to leave"
        )
      ),
      "Underestimating how long things take" = list(
        plain = "Most people underestimate how many steps are involved in getting somewhere. The realistic total is usually 2–3x the mental estimate.",
        label = "Prep time estimation",
        strategies = c(
          "Write out every single step of your getting-ready routine and time each one individually",
          "Build your departure time by working backward from arrival, including travel, parking, and walking",
          "Add a fixed buffer of at least 10–15 minutes — treat this as non-negotiable, not optional",
          "Create a 'getting ready checklist' that includes things you usually forget to count (shoes, bag check, eating, bathroom)",
          "The night before, confirm: do I know exactly where I'm going, how long it takes, and where I'll park?",
          "Identify your most common 'time leak' and build it into your plan by default",
          "Start a navigation app while you get ready so you can see how long it will take to get to your destination"
        )
      ),
      "Resistance to leaving or transitioning" = list(
        plain = "Leaving a comfortable or familiar situation can trigger real anxiety or emotional resistance — even when there's nothing scary about the destination.",
        label = "Transition anxiety",
        strategies = c(
          "Create a short, predictable 'launch routine' — the same 3–4 actions every time you leave so departing feels less jarring",
          "Give yourself a 'transition window' — 10 minutes where you're not doing your previous task but also not expected to be out the door yet",
          "Reduce decisions required before leaving by prepping the night before (bag packed, outfit chosen, route planned)",
          "Identify which part of going out feels worst and address that specifically rather than just pushing through",
          "Allow yourself to arrive and sit somewhere low-stimulation before entering — 'arrival' doesn't mean walking straight in",
          "If sensory issues are part of the resistance, prep sensory supports before you leave (headphones ready, sunglasses, familiar snack)"
        )
      )
    ),
    statement_map = list(
      "I think I have more time than I do" = "Difficulty sensing time passing",
      "I check the clock and think I'm fine, then suddenly I'm late" = "Difficulty sensing time passing",
      "I can't tell the difference between how 10 minutes feels vs. 30 minutes" = "Difficulty sensing time passing",
      "I lose track of time completely when I'm doing something" = "Difficulty sensing time passing",
      "I know what time I need to leave but I don't automatically figure out when to start getting ready" = "Underestimating how long things take",
      "I can't make myself stop what I'm doing even when I know I need to leave" = "Difficulty switching tasks",
      "I tell myself 'five more minutes' and then it's been 45 minutes" = "Difficulty switching tasks",
      "I underestimate how long getting ready actually takes" = "Underestimating how long things take",
      "I forget to count all the small steps — finding my keys, eating, walking to the bus" = "Underestimating how long things take",
      "I plan for the ideal version of getting ready, not the realistic version" = "Underestimating how long things take",
      "I feel resistance or dread about leaving even when I'm not running late" = "Resistance to leaving or transitioning",
      "I delay leaving because I don't feel mentally ready yet" = "Resistance to leaving or transitioning",
      "I get stuck checking things over and over before I can go" = "Resistance to leaving or transitioning",
      "I'd rather rush than wait somewhere early" = "Resistance to leaving or transitioning"
    )
  ),
  
  "Studying" = list(
    icon = "📚",
    preview = c("I re-read my notes but it doesn't go in", "I don't know when to fit studying in"),
    statements = c(
      "I sit down to study but don't know what to actually do",
      "I re-read my notes but it doesn't feel like it's going in",
      "I highlight everything and then realize I don't remember any of it",
      "I don't know how to study for this type of class or test",
      "I study but then go blank on the exam",
      "I know the material when I'm studying but can't retrieve it under pressure",
      "I know I need to study but I don't know when to fit it in",
      "I always plan to study later and later never comes",
      "I cram the night before because I didn't know when else to do it",
      "I don't know how far in advance to start studying",
      "Studying feels pointless when the exam is still weeks away"
    ),
    causes = list(
      "Using strategies that don't actually work" = list(
        plain = "Re-reading and highlighting feel productive but are among the least effective study strategies. The method matters as much as the time you put in.",
        label = "Strategy mismatch",
        strategies = c(
          "Replace re-reading with active recall: close your notes and try to write down everything you remember",
          "Use spaced repetition (apps like Anki) — review material across multiple sessions, not all at once",
          "Practice retrieval: do practice problems or past exams rather than reviewing the material",
          "Try the Feynman technique: explain the concept out loud as if teaching it to someone with no background",
          "Match your strategy to the test type — multiple choice needs recognition practice, essays need outline practice",
          "Study in shorter, focused bursts (25–30 min) rather than long sessions where attention drifts"
        )
      ),
      "Not knowing when or how much to study" = list(
        plain = "Without a concrete plan for when studying happens, it keeps getting pushed to 'later' — which eventually becomes the night before.",
        label = "Planning difficulty",
        strategies = c(
          "Work backward from the exam date: figure out how many sessions you need and schedule each one",
          "Treat study sessions like appointments — put them in your calendar with a specific time and topic",
          "Start earlier than feels necessary — by the time it feels urgent, you're already behind",
          "Plan for the minimum: even 20 minutes on a given day beats skipping entirely",
          "Use a weekly study planning template to map out when each subject gets time",
          "Build in a buffer week before exams for review — assume something will come up"
        )
      ),
      "Deadlines feeling far away" = list(
        plain = "When an exam is weeks away, the brain doesn't register urgency — so studying competes with everything that feels more immediate.",
        label = "Low deadline urgency",
        strategies = c(
          "Create artificial deadlines: set an internal goal to 'finish unit 1' by a date well before the exam",
          "Break the material into chunks and assign each chunk a date — make future work feel present",
          "Use a countdown: physically seeing '18 days until exam' changes how imminent it feels",
          "Start with just one page or one concept — getting started removes the distance",
          "Tell someone your study plan so there's mild external accountability",
          "Remind yourself that cramming works less well for your brain than spaced study, even when it doesn't feel that way"
        )
      )
    ),
    statement_map = list(
      "I sit down to study but don't know what to actually do" = "Using strategies that don't actually work",
      "I re-read my notes but it doesn't feel like it's going in" = "Using strategies that don't actually work",
      "I highlight everything and then realize I don't remember any of it" = "Using strategies that don't actually work",
      "I don't know how to study for this type of class or test" = "Using strategies that don't actually work",
      "I study but then go blank on the exam" = "Using strategies that don't actually work",
      "I know the material when I'm studying but can't retrieve it under pressure" = "Using strategies that don't actually work",
      "I know I need to study but I don't know when to fit it in" = "Not knowing when or how much to study",
      "I always plan to study later and later never comes" = "Not knowing when or how much to study",
      "I cram the night before because I didn't know when else to do it" = "Not knowing when or how much to study",
      "I don't know how far in advance to start studying" = "Not knowing when or how much to study",
      "Studying feels pointless when the exam is still weeks away" = "Deadlines feeling far away"
    )
  ),
  
  "Getting started" = list(
    icon = "🔲",
    preview = c("I know I need to do it but I just can't start", "The task feels too big to begin"),
    statements = c(
      "I know I need to do something but I just can't start",
      "I open my laptop to work and end up doing something else entirely",
      "I wait until the last minute even when I told myself I wouldn't",
      "The task feels so big I don't know where to even begin",
      "I sit down to work but feel paralyzed",
      "I don't know where to start",
      "I do easier tasks first and the important thing never gets done",
      "I need to be in the right headspace to start but that feeling never comes",
      "I work really well under pressure but pay for it afterward",
      "I'm not sure if I'm doing it right so I'd rather not start",
      "I feel overwhelmed just looking at the assignment description",
      "I start tasks but abandon them halfway through",
      "I spend more time thinking about doing the task than actually doing it"
    ),
    causes = list(
      "The task feels overwhelming or unclear" = list(
        plain = "When a task feels too big or the first step isn't obvious, the brain stalls. This isn't avoidance — it's a genuine cognitive block.",
        label = "Task overwhelm",
        strategies = c(
          "Define only the very next physical action — not 'write essay' but 'open a blank doc and write one sentence'",
          "Break the task into steps small enough that each one takes under 10 minutes",
          "Use a task breakdown worksheet to map out every component before you start",
          "Start with the easiest part of the task, not the most logical part — momentum matters more than order",
          "Set a 2-minute timer: commit to working for only 2 minutes, with permission to stop after",
          "Ask yourself 'what would the first 5% of this look like?' and only do that",
          "Try using a <a href='EisenhowerMatrix.pdf' target='_blank'>priority matrix</a> to figure out what tasks need to get done first"
        )
      ),
      "Waiting for motivation or the right feeling" = list(
        plain = "For many people, motivation follows action — it doesn't precede it. Waiting to feel ready often means never starting.",
        label = "Motivation-action loop",
        strategies = c(
          "Start before you feel ready — action creates motivation, not the other way around",
          "Lower the bar dramatically: the goal is to begin, not to do it well",
          "Create an 'activation ritual' — a short sequence (make tea, put on headphones, open your doc) that signals work time",
          "Use body doubling: work alongside someone else, in person or virtually (Focusmate, study streams)",
          "Remove the option to do something else first — close tabs, put phone in another room before sitting down",
          "Acknowledge the resistance without obeying it: 'I don't feel like it AND I'm starting anyway'"
        )
      ),
      "Fear of doing it wrong" = list(
        plain = "Perfectionism and fear of failure can make starting feel high-stakes. Not starting feels safer than starting badly.",
        label = "Perfectionism / fear of failure",
        strategies = c(
          "Give yourself explicit permission to write a bad first draft — the goal of starting is not quality",
          "Separate 'drafting' from 'editing' so you're not evaluating yourself while creating",
          "Remind yourself that revision is part of the process, not evidence that you failed",
          "Set a 'done is better than perfect' threshold and name it before you start",
          "Talk to a peer or TA early — getting input before you're invested reduces the stakes of feedback",
          "Notice the thought 'I might do this wrong' and respond with 'and I'll fix it if I do'"
        )
      )
    ),
    statement_map = list(
      "I know I need to do something but I just can't start" = "Waiting for motivation or the right feeling",
      "I open my laptop to work and end up doing something else entirely" = "Waiting for motivation or the right feeling",
      "I wait until the last minute even when I told myself I wouldn't" = "Waiting for motivation or the right feeling",
      "The task feels so big I don't know where to even begin" = "The task feels overwhelming or unclear",
      "I sit down to work but feel paralyzed" = "The task feels overwhelming or unclear",
      "I do easier tasks first and the important thing never gets done" = "The task feels overwhelming or unclear",
      "I need to be in the right headspace to start but that feeling never comes" = "Waiting for motivation or the right feeling",
      "I work really well under pressure but pay for it afterward" = "Waiting for motivation or the right feeling",
      "I'm not sure if I'm doing it right so I'd rather not start" = "Fear of doing it wrong",
      "I feel overwhelmed just looking at the assignment description" = "The task feels overwhelming or unclear",
      "I start tasks but abandon them halfway through" = "Fear of doing it wrong",
      "I spend more time thinking about doing the task than actually doing it" = "Fear of doing it wrong",
      "I don't know where to start" = "The task feels overwhelming or unclear"
    )
  ),
  
  "Keeping track" = list(
    icon = "📅",
    preview = c("I forget assignments exist until the night before", "My plans fall apart within days"),
    statements = c(
      "I make a plan and then completely abandon it within a few days",
      "My plans are too rigid and fall apart the moment something changes",
      "I forget assignments exist until the night before they're due",
      "I rely on remembering things in my head and it doesn't work",
      "I know I have a lot due but I can't remember exactly what or when",
      "I feel like I'm always behind even when I'm trying to stay on top of things",
      "I don't realize how long a project will take until I'm already out of time",
      "I always think I have more time than I do on a big-picture level",
      "I start assignments the day before because earlier doesn't feel real or urgent",
      "I lose track of smaller tasks that don't have hard deadlines",
      "I finish things at the last minute but feel like I'm barely surviving"
    ),
    causes = list(
      "Plans that are too rigid to survive real life" = list(
        plain = "Detailed hour-by-hour plans often collapse at the first disruption — because they have no flexibility built in.",
        label = "Overly rigid planning",
        strategies = c(
          "Plan by day, not by hour — assign tasks to days rather than specific time slots",
          "Build in at least one 'buffer' day per week with nothing scheduled — for overflow, not new tasks",
          "When your plan breaks, don't scrap it — just shift things forward and keep going",
          "Use a weekly review (10 minutes on Sunday) to reset and re-plan for the week ahead",
          "Try a 'top 3 tasks' system: each day, identify only the three most important things",
          "Use a Gantt chart or project timeline for longer assignments to see the full shape of the work (see templates <a href='https://excel.cloud.microsoft/create/en/gantt-charts/' target='_blank'>here</a>)",
          "Try menu planning: give yourself options of different tasks (when you can) and choose which one you feel most capable of doing"
        )
      ),
      "No reliable system for capturing tasks" = list(
        plain = "Working memory can't hold everything. Without an external system that captures everything in one place, things fall through the gaps.",
        label = "Capture system gaps",
        strategies = c(
          "Use one single place for all tasks — not three apps, not a mix of paper and phone, one system",
          "Add assignments to your system the moment they're given, not later",
          "Include soft deadlines (when you want to start) not just hard deadlines (when it's due)",
          "Use a <a href='semester-planning.xlsx' target='_blank'>spreadsheet template</a> that shows all assignments, due dates, and progress in one view",
          "Do a weekly 'brain dump' — write down everything that's in your head so nothing lives only there",
          "Use a Gantt chart or project timeline for longer assignments to see the full shape of the work (see templates <a href='https://excel.cloud.microsoft/create/en/gantt-charts/' target='_blank'>here</a>)",
          "Set recurring calendar reminders to check your task list, not just your calendar"
        )
      ),
      "Future deadlines not feeling real or urgent" = list(
        plain = "The further away something is, the less real it feels — so it competes poorly with everything that's happening now.",
        label = "Deadline salience",
        strategies = c(
          "As soon as an assignment is given, figure out when you need to *start*, not just when it's due",
          "Break projects into milestone deadlines and put those in your calendar, not just the final due date",
          "Use a countdown for major assignments so the shrinking number stays visible",
          "Ask: 'If I were to start this tomorrow, would I have everything I need?' If not, start now",
          "For long projects, work backward from the due date to create a start date that actually gives you enough time",
          "Schedule a first-pass session within 48 hours of an assignment being given, even just to read and plan"
        )
      )
    ),
    statement_map = list(
      "I make a plan and then completely abandon it within a few days" = "Plans that are too rigid to survive real life",
      "My plans are too rigid and fall apart the moment something changes" = "Plans that are too rigid to survive real life",
      "I forget assignments exist until the night before they're due" = "No reliable system for capturing tasks",
      "I rely on remembering things in my head and it doesn't work" = "No reliable system for capturing tasks",
      "I know I have a lot due but I can't remember exactly what or when" = "No reliable system for capturing tasks",
      "I feel like I'm always behind even when I'm trying to stay on top of things" = "No reliable system for capturing tasks",
      "I don't realize how long a project will take until I'm already out of time" = "Future deadlines not feeling real or urgent",
      "I always think I have more time than I do on a big-picture level" = "Future deadlines not feeling real or urgent",
      "I start assignments the day before because earlier doesn't feel real or urgent" = "Future deadlines not feeling real or urgent",
      "I lose track of smaller tasks that don't have hard deadlines" = "No reliable system for capturing tasks",
      "I finish things at the last minute but feel like I'm barely surviving" = "Future deadlines not feeling real or urgent"
    )
  ),
  
  "Test anxiety" = list(
    icon = "😰",
    preview = c("My mind goes blank even when I studied", "I spiral right before or during an exam"),
    statements = c(
      "My mind goes blank during exams even when I studied",
      "I know the material until I sit down to take the test",
      "I spiral into worst-case thinking right before or during an exam",
      "My body feels physically anxious — heart racing, can't focus",
      "I spend so long on one question I run out of time",
      "I second-guess every answer even when I knew it initially",
      "I do fine on practice tests but fall apart on real ones"
    ),
    causes = list(
      "Anxiety hijacking memory retrieval" = list(
        plain = "Stress hormones physically interfere with memory access. This is why people 'know it until they sit down' — anxiety blocks retrieval, not storage.",
        label = "Retrieval interference",
        strategies = c(
          "Practice retrieval under mild stress conditions — timed practice tests before the real thing",
          "Before the exam, do a 'brain dump' — write down everything you remember on scratch paper before reading questions",
          "Use slow breathing (4 counts in, hold 4, out 4) to reduce cortisol before and during the exam",
          "Develop a pre-exam routine that signals safety to your nervous system — same music, same snack, same sequence",
          "Practice the 5-4-3-2-1 grounding technique if you feel anxiety spiking during the exam (<a href='Grounding+Exercise+FINAL.pdf' target='_blank'>open 5-4-3-2-1 worksheet</a>)",
          "If you go blank on a question, mark it, move on, and come back — returning with a fresh start often unlocks it"
        )
      ),
      "Catastrophic thinking patterns" = list(
        plain = "When anxiety is high, the brain predicts worst-case outcomes automatically. These thoughts feel true but are usually not accurate.",
        label = "Catastrophizing",
        strategies = c(
          "Name the thought: 'I'm having the thought that I'm going to fail' rather than 'I'm going to fail'",
          "Ask: what's the realistic outcome, not the worst-case? What actually happens if you do poorly on this one exam?",
          "Prepare a short self-compassion script for before the exam — something you'd say to a friend who was anxious",
          "Use box breathing or a brief body scan to interrupt the spiral before it escalates",
          "Remind yourself that anxiety feels like danger but isn't — your body is trying to help, not hurt you",
          "After the exam, debrief with yourself: did the worst-case actually happen? Build evidence over time"
        )
      ),
      "Time pressure and pacing" = list(
        plain = "Getting stuck on one question and losing track of time is a common pattern — and fixable with a concrete strategy.",
        label = "Time management during exams",
        strategies = c(
          "Before starting, calculate roughly how many minutes per question you have and keep track",
          "Set a personal rule: if you've spent more than 1.5x the average time on a question, mark it and move on",
          "Answer every question you're confident about first, then return to uncertain ones",
          "Write a quick note on hard questions so you don't lose your partial thinking when you return",
          "Practice timed tests regularly so time pressure becomes familiar rather than alarming"
        )
      )
    ),
    statement_map = list(
      "My mind goes blank during exams even when I studied" = "Anxiety hijacking memory retrieval",
      "I know the material until I sit down to take the test" = "Anxiety hijacking memory retrieval",
      "I spiral into worst-case thinking right before or during an exam" = "Catastrophic thinking patterns",
      "My body feels physically anxious — heart racing, can't focus" = "Catastrophic thinking patterns",
      "I spend so long on one question I run out of time" = "Time pressure and pacing",
      "I second-guess every answer even when I knew it initially" = "Catastrophic thinking patterns",
      "I do fine on practice tests but fall apart on real ones" = "Anxiety hijacking memory retrieval"
    )
  ),
  
  "Note-taking" = list(
    icon = "📝",
    preview = c("I can't keep up with the lecture", "My notes make no sense afterward"),
    statements = c(
      "I write everything down and end up with pages I can't use later",
      "I can't keep up with the pace of the lecture",
      "I'm so focused on writing I don't actually absorb what's being said",
      "I don't know what's important enough to write down",
      "My notes make sense in class but mean nothing when I look at them later",
      "I zone out and miss chunks of the lecture",
      "I write things down and then can't find them when I need them"
    ),
    causes = list(
      "Transcribing instead of processing" = list(
        plain = "Trying to write everything down prevents actual understanding. Notes should capture meaning, not serve as a transcript.",
        label = "Over-transcription",
        strategies = c(
          "Try Cornell notes: main notes on the right, key questions on the left, summary at the bottom",
          "Write in your own words, not the professor's — this forces processing",
          "After class, spend 10 minutes writing a summary from memory before looking at your notes",
          "Use symbols and abbreviations so writing is faster and you can focus more on listening",
          "Try concept maps or diagrams for topics with a lot of relationships between ideas",
          "Record lectures (with permission) so you can listen actively and fill in gaps later"
        )
      ),
      "Difficulty knowing what matters" = list(
        plain = "Without a clear signal for what's important, everything feels equally worth writing down — which is overwhelming.",
        label = "Prioritization difficulty",
        strategies = c(
          "Before class, briefly review the slides or reading so you have a framework for what's coming",
          "Listen for verbal cues: 'this is important,' repetition, things written on the board, exam mentions",
          "Focus on capturing main ideas, examples, and anything that seems to confuse you",
          "After class, mark your notes with a highlighter for anything you'd want on a study guide",
          "Ask the professor or TA what the key takeaways from each class are — many are happy to answer"
        )
      ),
      "Attention and focus during lectures" = list(
        plain = "Long lectures are hard to sustain attention through — especially in passive listening environments.",
        label = "Sustaining attention",
        strategies = c(
          "Sit where it's easiest to focus — usually closer to the front, away from high-traffic areas",
          "Give yourself a focus task: write one question you want answered by the end of class",
          "Use the outline in slides as a scaffold — fill in details under each heading rather than starting from scratch",
          "If you zone out, note the timestamp if recorded, or just write 'gap here' — don't spiral, just continue",
          "Try different note formats to find what keeps you more engaged: linear, visual, typed vs. handwritten",
          "Take brief mental breaks by looking away for 5 seconds — micro-rests help sustain longer attention"
        )
      )
    ),
    statement_map = list(
      "I write everything down and end up with pages I can't use later" = "Transcribing instead of processing",
      "I can't keep up with the pace of the lecture" = "Transcribing instead of processing",
      "I'm so focused on writing I don't actually absorb what's being said" = "Transcribing instead of processing",
      "I don't know what's important enough to write down" = "Difficulty knowing what matters",
      "My notes make sense in class but mean nothing when I look at them later" = "Transcribing instead of processing",
      "I zone out and miss chunks of the lecture" = "Attention and focus during lectures",
      "I write things down and then can't find them when I need them" = "Difficulty knowing what matters"
    )
  ),
  
  "Focus" = list(
    icon = "🧠",
    preview = c("My mind goes everywhere except the task", "I can only focus on things I care about"),
    statements = c(
      "I sit down to work and my mind goes everywhere except the task",
      "I can focus for a few minutes but then lose it",
      "I can only focus on things I'm genuinely interested in",
      "Background noise or activity makes it impossible to concentrate",
      "I focus intensely on the wrong thing and lose hours",
      "I get distracted by my phone even when I've tried to put it away",
      "I do my best work at weird hours and it affects everything else",
      "I hyperfocus sometimes but can't access it on demand",
      "Certain environments make focus impossible but I can't always control where I study"
    ),
    causes = list(
      "Interest-based attention system" = list(
        plain = "Many neurodivergent brains are wired for interest-driven attention — focus comes easily for engaging tasks and barely at all for low-interest ones. This isn't laziness.",
        label = "Interest-based attention",
        strategies = c(
          "Find the angle of a task that's genuinely interesting and start there",
          "Add novelty: new location, new playlist, different format (type instead of write, or vice versa)",
          "Gamify your task (try <a href='https://habitica.com/static/home' target='_blank'>Habitica</a>)",
          "Create mild stakes: tell someone what you're working on, or use a study-with-me stream (<a href='https://www.youtube.com/watch?v=nkOHI8rvyYY' target='_blank'>Example study stream</a>)",
          "Use a reward that follows the work — something to look forward to that makes the session feel finite",
          "Try 'temptation bundling': pair the boring task with something enjoyable (favorite drink, good music)",
          "Break work into very short sprints so the end is always visible (<a href='https://pomofocus.io/' target='_blank'>Try Pomodoro timers</a>)"
        )
      ),
      "External sensory distractions" = list(
        plain = "Some nervous systems are more sensitive to sensory input, making typical environments genuinely harder to focus in.",
        label = "Sensory sensitivity",
        strategies = c(
          "Identify your best environment: sound level, lighting, crowd level, temperature — and seek it out",
          "Use noise-cancelling headphones, earplugs, or brown/white noise to create a consistent sound environment",
          "Try different background sounds: some people focus better with music, others with ambient noise, others with silence",
          "If you can't control your environment, control what you can: face a wall, use earplugs, wear a hood",
          "Study at times when your preferred environment is available — early morning in libraries, for example",
          "Have a 'focus kit' ready to go: headphones, preferred drink, fidget tool, so setup takes no time"
        )
      ),
      "Digital distraction" = list(
        plain = "Phones and the internet are designed to capture attention — willpower alone is rarely enough to override that.",
        label = "Digital distraction",
        strategies = c(
          "Put your phone in another room — out of sight is genuinely more effective than face-down on the desk",
          "Use website blockers (Freedom, Cold Turkey) to remove the option during focus sessions",
          "Use apps that disincentivize phone use (Flora, Focus Friend)",
          "Put your phone in black and white when you need to focus",
          "Turn off all non-essential notifications permanently, not just during study sessions",
          "Use a dedicated 'work' browser profile with no bookmarks to social media or distracting sites",
          "Keep a 'distraction notepad' — when you think of something else, write it down and return to work",
          "If you need your phone nearby, put it in grayscale — color is a large part of what makes it compelling"
        )
      )
    ),
    statement_map = list(
      "I sit down to work and my mind goes everywhere except the task" = "Interest-based attention system",
      "I can focus for a few minutes but then lose it" = "Interest-based attention system",
      "I can only focus on things I'm genuinely interested in" = "Interest-based attention system",
      "Background noise or activity makes it impossible to concentrate" = "External sensory distractions",
      "I focus intensely on the wrong thing and lose hours" = "Interest-based attention system",
      "I get distracted by my phone even when I've tried to put it away" = "Digital distraction",
      "I do my best work at weird hours and it affects everything else" = "External sensory distractions",
      "I hyperfocus sometimes but can't access it on demand" = "Interest-based attention system",
      "Certain environments make focus impossible but I can't always control where I study" = "External sensory distractions"
    )
  ),
  
  "Asking for help" = list(
    icon = "🗣️",
    preview = c("I don't know what I'm entitled to", "I don't want to seem like I'm making excuses"),
    statements = c(
      "I don't know what accommodations I'm entitled to or how to get them",
      "I know I need something but I don't know how to put it into words",
      "I feel nervous or embarrassed asking professors for help or flexibility",
      "I've tried explaining my needs before and felt dismissed or misunderstood",
      "I don't reach out until I'm already in crisis",
      "I don't want to seem like I'm making excuses",
      "I'm not sure if what I'm struggling with is 'bad enough' to ask for support"
    ),
    causes = list(
      "Not knowing what support exists" = list(
        plain = "Many students don't know what they're eligible for — or assume they need a formal diagnosis to deserve any help.",
        label = "Information gaps",
        strategies = c(
          "Contact your university's accessibility or disability services office — many supports are available without a formal diagnosis",
          "Ask what documentation is required before assuming you don't qualify",
          "Look up your institution's academic policies on extensions, incompletes, and late withdrawals — these exist for everyone",
          "Talk to a student advisor or ombudsperson if you're unsure where to start",
          "Peer support groups and neurodiversity communities on campus often have the most practical information",
          "Use the communication scripts in this toolkit to help put your needs into words"
        )
      ),
      "Fear of judgment or dismissal" = list(
        plain = "Worrying about being seen as making excuses, or having had past experiences of being dismissed, makes asking for help feel risky.",
        label = "Self-advocacy barriers",
        strategies = c(
          "You don't need to justify or explain your diagnosis — you can simply describe what you need and why it helps",
          "Email is often easier than in-person for difficult conversations — it gives you time to think and them time to respond",
          "Start with the most approachable person: a TA, an academic coach, or a peer before going to a professor",
          "Use a script: 'I'm having difficulty with X. I was wondering if Y might be possible. I'm happy to discuss further.'",
          "Remember that most instructors want students to succeed — reaching out signals effort, not weakness",
          "If you're dismissed, you have the right to escalate to a department coordinator or accessibility office"
        )
      ),
      "Waiting until crisis to reach out" = list(
        plain = "Reaching out early — before things are urgent — almost always leads to better outcomes than reaching out in crisis.",
        label = "Reactive help-seeking",
        strategies = c(
          "Set a personal rule: if you've missed two consecutive classes or one assignment, reach out that day",
          "Email professors at the start of term to introduce yourself — a prior relationship makes later asks easier",
          "Use a check-in schedule: once a week, ask yourself 'is anything building up that I should address now?'",
          "Identify your early warning signs that things are getting hard and treat those as the trigger for reaching out",
          "Academic coaches and advisors exist for exactly this — you don't need to be in crisis to use them",
          "Practice the ask in low-stakes situations (office hours for a quick question) to build confidence"
        )
      )
    ),
    statement_map = list(
      "I don't know what accommodations I'm entitled to or how to get them" = "Not knowing what support exists",
      "I know I need something but I don't know how to put it into words" = "Not knowing what support exists",
      "I feel nervous or embarrassed asking professors for help or flexibility" = "Fear of judgment or dismissal",
      "I've tried explaining my needs before and felt dismissed or misunderstood" = "Fear of judgment or dismissal",
      "I don't reach out until I'm already in crisis" = "Waiting until crisis to reach out",
      "I don't want to seem like I'm making excuses" = "Fear of judgment or dismissal",
      "I'm not sure if what I'm struggling with is 'bad enough' to ask for support" = "Not knowing what support exists"
    )
  ),
  
  "Burnout" = list(
    icon = "🔋",
    preview = c("I'm exhausted in a way that sleep doesn't fix", "I'm functioning but running on empty"),
    statements = c(
      "I feel exhausted in a way that sleep doesn't fix",
      "I used to be able to manage things that now feel impossible",
      "I've stopped caring about things that used to matter to me",
      "I feel like I'm performing being a student but nothing is actually landing",
      "Everything takes enormous effort — even simple things",
      "I feel like I'm constantly masking or performing and it's draining me",
      "I hit a wall and completely shut down — no output at all",
      "I'm functioning but I feel like I'm running on empty"
    ),
    causes = list(
      "Early warning signs" = list(
        plain = "Burnout builds gradually. Recognizing the early signs gives you the most room to respond before things become severe.",
        label = "Early stage burnout",
        strategies = c(
          "Notice the pattern: increased irritability, reduced output, loss of interest in things you usually enjoy",
          "Track your energy across the week — are there consistent lows that are getting worse over time?",
          "Build non-negotiable rest into your schedule — not as a reward, but as a requirement",
          "Identify what's draining you most and reduce it if at all possible, even temporarily",
          "Reduce masking where safe to do so — the energy cost of performing is real and cumulative",
          "Talk to someone you trust about how you're feeling — externalizing it often makes it more manageable"
        )
      ),
      "Already burned out" = list(
        plain = "When burnout has fully set in, recovery requires real rest — not just a weekend off. This is a physiological state, not a motivation problem.",
        label = "Full burnout",
        strategies = c(
          "Acknowledge that this is burnout, not laziness — trying to push through often makes it worse and longer",
          "Identify what is absolutely non-negotiable right now and let everything else go temporarily",
          "Talk to your accessibility office, advisor, or a counselor — there are formal options (medical withdrawal, incomplete grades) that can create space",
          "Prioritize sleep, food, and one restorative activity above academic output for the immediate period",
          "Reduce stimulation where possible: less social media, less noise, more quiet and predictable environments",
          "Recovery from burnout is measured in weeks to months — be realistic about timelines and compassionate with yourself"
        )
      ),
      "Preventing future burnout" = list(
        plain = "Burnout is more likely when protective factors are missing — like autonomy, rest, connection, and environments that don't require constant masking.",
        label = "Prevention",
        strategies = c(
          "Identify your personal risk factors: what conditions reliably lead to exhaustion for you specifically?",
          "Build recovery time into your schedule proactively — don't wait until you're depleted",
          "Pursue accommodations that reduce the environmental demands causing the most drain (see <a href='Sensory-Overwhelm.pdf' target='_blank'>worksheet for sensory overload</a>)",
          "Maintain at least one activity per week that is purely restorative and non-productive",
          "Use a <a href='dopamine-menu.pdf' target='_blank'>dopamine menu</a> so you can more easily fit in restorative activities",
          "Monitor your baseline: if your 'normal' tiredness has shifted upward, that's a signal to act",
          "Know your support network in advance — who can you call when things get hard?"
        )
      )
    ),
    statement_map = list(
      "I feel exhausted in a way that sleep doesn't fix" = "Already burned out",
      "I used to be able to manage things that now feel impossible" = "Already burned out",
      "I've stopped caring about things that used to matter to me" = "Already burned out",
      "I feel like I'm performing being a student but nothing is actually landing" = "Early warning signs",
      "Everything takes enormous effort — even simple things" = "Already burned out",
      "I feel like I'm constantly masking or performing and it's draining me" = "Preventing future burnout",
      "I hit a wall and completely shut down — no output at all" = "Already burned out",
      "I'm functioning but I feel like I'm running on empty" = "Early warning signs"
    )
  )
)

# CSS

app_css <- "
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@300;400;500;600&family=DM+Serif+Display&display=swap');

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
  font-family: 'DM Sans', sans-serif;
  background: #F7F5F2;
  color: #1a1a2e;
  min-height: 100vh;
}

.app-shell {
  max-width: 900px;
  margin: 0 auto;
  padding: 48px 24px 80px;
}

/* ── Header ── */
.site-header {
  margin-bottom: 48px;
}
.site-header .eyebrow {
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: #6DBFA8;
  margin-bottom: 10px;
}
.site-header h1 {
  font-family: 'DM Serif Display', serif;
  font-size: clamp(32px, 5vw, 48px);
  color: #1a1a2e;
  line-height: 1.15;
  margin-bottom: 12px;
}
.site-header .subtitle {
  font-size: 16px;
  color: #666;
  font-weight: 300;
  max-width: 520px;
  line-height: 1.6;
}

/* ── Cluster grid ── */
.cluster-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 16px;
}

.cluster-card {
  background: #fff;
  border: 1.5px solid #E8E4DF;
  border-radius: 14px;
  padding: 22px 20px 20px;
  cursor: pointer;
  transition: all 0.18s ease;
  text-align: left;
  width: 100%;
  display: block;
  position: relative;
  overflow: hidden;
}
.cluster-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: #6DBFA8;
  transform: scaleX(0);
  transform-origin: left;
  transition: transform 0.2s ease;
}
.cluster-card:hover {
  border-color: #6DBFA8;
  box-shadow: 0 6px 24px rgba(109,191,168,0.15);
  transform: translateY(-2px);
}
.cluster-card:hover::before { transform: scaleX(1); }

.cluster-card .card-icon {
  font-size: 28px;
  margin-bottom: 10px;
  display: block;
}
.cluster-card .card-title {
  font-size: 15px;
  font-weight: 600;
  color: #1a1a2e;
  margin-bottom: 8px;
}
.cluster-card .card-previews {
  font-size: 12.5px;
  color: #888;
  line-height: 1.55;
}
.card-previews span {
  display: block;
}
.card-previews span::before {
  content: '\\201C';
  color: #6DBFA8;
}
.card-previews span::after {
  content: '\\201D';
  color: #6DBFA8;
}

/* ── Back button ── */
.back-btn {
  background: none;
  border: none;
  cursor: pointer;
  color: #6DBFA8;
  font-size: 13.5px;
  font-family: 'DM Sans', sans-serif;
  font-weight: 500;
  padding: 0;
  margin-bottom: 32px;
  display: flex;
  align-items: center;
  gap: 6px;
  letter-spacing: 0.01em;
}
.back-btn:hover { color: #3B4F6B; }

/* ── Cluster detail ── */
.cluster-detail-header {
  margin-bottom: 36px;
}
.cluster-detail-header .cluster-icon-lg {
  font-size: 40px;
  margin-bottom: 10px;
  display: block;
}
.cluster-detail-header h2 {
  font-family: 'DM Serif Display', serif;
  font-size: 30px;
  color: #1a1a2e;
  margin-bottom: 6px;
}
.cluster-detail-header .section-sub {
  font-size: 14px;
  color: #888;
  font-weight: 300;
}

/* ── Checkboxes Section ── */
.statements-section {
  background: #fff;
  border: 1.5px solid #E8E4DF;
  border-radius: 14px;
  padding: 26px 26px 20px;
  margin-bottom: 32px;
}
.statements-section h3 {
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: #6DBFA8;
  margin-bottom: 16px;
}

/* Overrides Shiny's default 300px max-width on inputs so text spans full width */
  .statements-section .shiny-input-container {
    max-width: 100% !important;
    width: 100% !important;
  }

/* Fix for Bootstrap's default checkbox wrapping and alignment */
.checkbox {
  margin-top: 10px;
  margin-bottom: 10px;
}
.checkbox label {
  display: flex !important;
  align-items: flex-start;
  width: 100%;
  padding-left: 0 !important; 
  font-size: 15px;
  color: #333;
  line-height: 1.45;
  font-weight: 400;
  cursor: pointer;
}
.checkbox input[type='checkbox'] {
  position: static !important;
  margin-left: 0 !important;
  margin-right: 12px !important;
  margin-top: 3px !important;
  flex-shrink: 0;
  cursor: pointer;
}

/* Show All Wrapper & Button */
.show-all-wrapper {
  margin-top: 24px;
  padding-top: 20px;
  border-top: 1px solid #E8E4DF;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 12px;
}
.show-all-text {
  font-size: 13.5px;
  color: #666;
  line-height: 1.5;
}
.btn-show-all {
  background-color: transparent;
  border: 1.5px solid #6DBFA8;
  color: #6DBFA8;
  border-radius: 8px;
  padding: 8px 16px;
  font-size: 13.5px;
  font-weight: 600;
  transition: all 0.2s ease;
}
.btn-show-all:hover {
  background-color: #6DBFA8;
  color: #fff;
}

/* ── Causes ── */
.causes-heading {
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: #3B4F6B;
  margin-bottom: 16px;
}
.causes-grid {
  display: flex;
  flex-direction: column;
  gap: 14px;
  margin-bottom: 0;
}
.cause-card {
  background: #fff;
  border: 1.5px solid #E8E4DF;
  border-radius: 14px;
  overflow: hidden;
}
.cause-header {
  padding: 20px 22px 16px;
  cursor: pointer;
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 16px;
  transition: background 0.15s;
}
.cause-header:hover { background: #FAFAF9; }
.cause-header-left { flex: 1; }
.cause-label {
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: #6DBFA8;
  margin-bottom: 4px;
}
.cause-title {
  font-size: 16px;
  font-weight: 600;
  color: #1a1a2e;
  margin-bottom: 8px;
}
.cause-plain {
  font-size: 13.5px;
  color: #666;
  line-height: 1.6;
  font-weight: 300;
}
.cause-toggle {
  font-size: 20px;
  color: #6DBFA8;
  flex-shrink: 0;
  margin-top: 2px;
  transition: transform 0.2s;
  font-weight: 300;
}
.cause-toggle.open { transform: rotate(45deg); }

.cause-strategies {
  display: none;
  padding: 0 22px 20px;
  border-top: 1px solid #F0EDE8;
}
.cause-strategies.open { display: block; }
.strategies-label {
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: #3B4F6B;
  margin: 16px 0 12px;
}
.strategies-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.strategies-list li {
  font-size: 13.5px;
  color: #333;
  line-height: 1.55;
  padding: 10px 14px;
  background: #F7F5F2;
  border-radius: 8px;
  position: relative;
  padding-left: 30px;
}
.strategies-list li::before {
  content: '→';
  position: absolute;
  left: 12px;
  color: #6DBFA8;
  font-size: 13px;
}

/* ── Animations ── */
@keyframes fadeSlideIn {
  from { opacity: 0; transform: translateY(12px); }
  to   { opacity: 1; transform: translateY(0); }
}
.anim-in {
  animation: fadeSlideIn 0.28s ease forwards;
}
.cluster-card {
  animation: fadeSlideIn 0.3s ease forwards;
}

/* ── Responsive ── */
@media (max-width: 600px) {
  .app-shell { padding: 32px 16px 60px; }
  .cluster-grid { grid-template-columns: 1fr 1fr; }
}
@media (max-width: 400px) {
  .cluster-grid { grid-template-columns: 1fr; }
}
"

# ─────────────────────────────────────────────
# UI
# ─────────────────────────────────────────────
ui <- fluidPage(
  tags$head(
    tags$style(HTML(app_css)),
    tags$script(HTML("
      Shiny.addCustomMessageHandler('toggleStrategy', function(id) {
        var el = document.getElementById('strat_' + id);
        var toggle = document.getElementById('toggle_' + id);
        if (el) {
          el.classList.toggle('open');
          if (toggle) toggle.classList.toggle('open');
        }
      });
    "))
  ),

  div(class = "app-shell",
      
      # Header
      div(class = "site-header",
          div(class = "eyebrow", "Neurodiversity-Inclusive Academic Toolkit"),
          tags$h1("What's been hard lately?"),
          div(class = "subtitle",
              "Find strategies designed for how your brain actually works — not generic advice."
          )
      ),
      
      # Home grid (shown when no cluster selected)
      uiOutput("home_ui"),
      
      # Split Cluster UI into Header (Static) and Causes (Dynamic)
      uiOutput("cluster_header_ui"),
      uiOutput("cluster_causes_ui")
  )
)

# ─────────────────────────────────────────────
# SERVER
# ─────────────────────────────────────────────
server <- function(input, output, session) {
  
  selected_cluster <- reactiveVal(NULL)
  show_all_state <- reactiveVal(FALSE) # Track "Show All" button state
  
  selected_causes <- reactive({
    req(selected_cluster())
    cl <- clusters[[selected_cluster()]]
    
    # Show all if button clicked
    if (show_all_state()) {
      return(names(cl$causes))
    }
    
    # No selection yet
    if (is.null(input$selected_statements) || length(input$selected_statements) == 0) {
      return(NULL)
    }
    
    if (is.null(cl$statement_map)) {
      return(names(cl$causes))  # fallback
    }
    
    mapped <- cl$statement_map[input$selected_statements]
    mapped <- mapped[!is.na(mapped)]
    
    unique(unlist(mapped))
  })
  
  # ── Homepage grid ──
  output$home_ui <- renderUI({
    req(is.null(selected_cluster()))
    div(class = "cluster-grid anim-in",
        lapply(names(clusters), function(name) {
          cl <- clusters[[name]]
          tags$button(
            class = "cluster-card",
            onclick = sprintf("Shiny.setInputValue('selected_cluster', '%s', {priority: 'event'})", name),
            tags$span(class = "card-icon", cl$icon),
            div(class = "card-title", name),
            div(class = "card-previews",
                lapply(cl$preview, function(p) tags$span(p))
            )
          )
        })
    )
  })
  
  # ── Observe cluster selection ──
  observeEvent(input$selected_cluster, {
    selected_cluster(input$selected_cluster)
    show_all_state(FALSE) # Reset state when navigating to a new cluster
  })
  
  # ── Back button ──
  observeEvent(input$go_home, {
    selected_cluster(NULL)
    show_all_state(FALSE) # Reset state
  })
  
  # ── Show All Button ──
  observeEvent(input$show_all, {
    show_all_state(TRUE)
  })
  
  # ── Cluster detail page: HEADER (Only redraws when changing cluster category) ──
  output$cluster_header_ui <- renderUI({
    req(!is.null(selected_cluster()))
    cl <- clusters[[selected_cluster()]]
    
    div(class = "anim-in",
        # Back
        tags$button(
          class = "back-btn",
          id = "go_home",
          onclick = "Shiny.setInputValue('go_home', Math.random())",
          "← All topics"
        ),
        
        # Header
        div(class = "cluster-detail-header",
            tags$span(class = "cluster-icon-lg", cl$icon),
            tags$h2(selected_cluster()),
            div(class = "section-sub", "Select what resonates, then explore what might help.")
        ),
        
        # Statements Checkboxes
        div(class = "statements-section",
            tags$h3("Do any of these sound like you?"),
            checkboxGroupInput(
              inputId = "selected_statements",
              label = NULL,
              choices = cl$statements
            ),
            
            # Separated Show All Option
            div(class = "show-all-wrapper",
                div(class = "show-all-text", "None of these feel right, I'm not sure, or I want to see all strategies for this problem:"),
                actionButton("show_all", "Show all strategies", class = "btn-show-all")
            )
        )
    )
  })
  
  # ── Cluster detail page: CAUSES (Redraws dynamically as checkboxes are clicked) ──
  output$cluster_causes_ui <- renderUI({
    req(!is.null(selected_cluster()))
    cl <- clusters[[selected_cluster()]]
    visible_causes <- selected_causes()
    
    if (is.null(visible_causes)) {
      return(
        div(class = "anim-in", style = "color:#888; font-size:14px; margin-top:10px;",
            "Select one or more statements above to see strategies tailored to you."
        )
      )
    } 
    
    div(class = "anim-in",
      div(class = "causes-heading", "What might be going on"),
      div(class = "causes-grid",
          lapply(seq_along(cl$causes), function(i) {
            cause_name <- names(cl$causes)[i]
            
            if (!(cause_name %in% visible_causes)) return(NULL)
            
            cause_data <- cl$causes[[i]]
            uid <- gsub("[^a-zA-Z0-9]", "_", paste0(selected_cluster(), "_", i))
            
            div(class = "cause-card",
                div(class = "cause-header",
                    onclick = sprintf(
                      "document.getElementById('strat_%s').classList.toggle('open'); document.getElementById('toggle_%s').classList.toggle('open');",
                      uid, uid
                    ),
                    div(class = "cause-header-left",
                        div(class = "cause-label", cause_data$label),
                        div(class = "cause-title", cause_name),
                        div(class = "cause-plain", cause_data$plain)
                    ),
                    div(class = "cause-toggle", id = paste0("toggle_", uid), "+")
                ),
                div(class = "cause-strategies", id = paste0("strat_", uid),
                    div(class = "strategies-label", "Strategies"),
                    tags$ul(class = "strategies-list",
                            lapply(cause_data$strategies, function(x) tags$li(HTML(x)))
                    )
                )
            )
          })
      )
    )
  })
}

shinyApp(ui, server)
