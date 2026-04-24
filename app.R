library(shiny)
library(shinyjs)

`%||%` <- function(a, b) if (!is.null(a) && nchar(as.character(a)) > 0) a else b

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
          "Use a visual timer (like the Time Timer app or <a href='https://visualtimer.com/' target='_blank'>https://visualtimer.com/</a>) so time passing is something you can see, not just a number",
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
          "Use a <a href='https://excel.cloud.microsoft/create/en/gantt-charts/' target='_blank'>Gantt chart</a> or project timeline for longer assignments to see the full shape of the work",
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
          "As soon as an assignment is given, figure out when you need to start, not just when it's due",
          "Break projects into milestone deadlines and put those in your calendar, not just the final due date",
          "Use a countdown for major assignments so the shrinking number stays visible",
          "Ask: 'If I were to start this tomorrow, would I have everything I need?' If not, start now",
          "For long projects, work backward from the due date to create a start date that actually gives you enough time (<a href='backwards-planning-worksheet.pdf' target='_blank'>see backwards planning worksheet</a>)",
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
          "Use slow breathing (4 counts in, hold 4, out 4) to calm your nervous system before and during the exam (<a href='breathing-exercises.pdf' target='_blank'>see here for more breathing exercises</a>)",
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


ui <- fluidPage(
  shinyjs::useShinyjs(),
  tags$head(
    tags$script(src = "https://cdn.jsdelivr.net/npm/interactjs/dist/interact.min.js"),
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    tags$script(HTML("
      Shiny.addCustomMessageHandler('setFontScale', function(msg) {
        var scaleMap = {
          '14px': 1,
          '18px': 1.15,
          '22px': 1.3
        };
        var scale = scaleMap[msg.size] || 1;
        var app = document.querySelector('.app-shell');
        if (app) {
          app.style.zoom = scale;
        }
      });
      $(document).on('click','#accessibility-dropdown-btn',function(e){
        e.preventDefault();e.stopPropagation();$('#accessibility-dropdown-menu').toggle();
      });
      $(document).on('click', '#accessibility-dropdown-menu', function(e){
        e.stopPropagation();
      });
      $(document).on('click',function(e){
        if(!$(e.target).closest('#toolbar-accessibility').length)$('#accessibility-dropdown-menu').hide();
      });

      // Pill radio styling
      function updatePills(container){
        $(container).find('input[type=radio]').each(function(){
          var wrap=$(this).closest('.radio');
          if(wrap.length){
            if(this.checked) wrap.addClass('pill-active');
            else wrap.removeClass('pill-active');
          }
        });
      }
      $(document).on('change','.pill-group input[type=radio]',function(){
        updatePills($(this).closest('.pill-group'));
      });
      Shiny.addCustomMessageHandler('initPills',function(x){
        document.querySelectorAll('.pill-group').forEach(updatePills);
      });

      // Step checkbox toggle (pure client-side)
      $(document).on('click','.step-item',function(){
        $(this).toggleClass('step-done');
        var total=$('.step-item').length;
        var done=$('.step-item.step-done').length;
        var pct=total>0?Math.round(done/total*100):0;
        $('.chunker-progress-fill').css('width',pct+'%');
        $('.chunker-progress-count').text(done+' / '+total+' done');
        if(done===total&&total>0){$('#chunker-celebration').slideDown(200);}
        else{$('#chunker-celebration').hide();}
      });

      // Interact.js drag
      $(document).on('shiny:idle',function(){
        if(window._interactInit)return;
        window._interactInit=true;
        interact('.sticky-note').draggable({
          listeners:{
            move:function(e){
              var t=e.target;
              var x=(parseFloat(t.getAttribute('data-x'))||0)+e.dx;
              var y=(parseFloat(t.getAttribute('data-y'))||0)+e.dy;
              t.style.transform='translate('+x+'px,'+y+'px)';
              t.setAttribute('data-x',x);t.setAttribute('data-y',y);
            },
            end:function(e){
              var t=e.target;
              Shiny.setInputValue('matrix_drag_update',{
                id:t.id,x:parseFloat(t.getAttribute('data-x')),
                y:parseFloat(t.getAttribute('data-y')),nonce:Math.random()
              });
            }
          }
        });
      });
    "))
  ),
  
  div(class="app-shell",
      
      tags$div(id="toolbar-accessibility",
               actionButton("accessibility-dropdown-btn",
                            label=tagList(icon("universal-access")," Accessibility"),
                            class="btn btn-default"),
               tags$div(id="accessibility-dropdown-menu",class="dropdown-menu",
                        tags$div(style="margin-bottom:12px;",
                                 tags$label("Text Size:",style="font-weight:600;display:block;margin-bottom:6px;"),
                                 selectInput(
                                   "font_scale",
                                   label = NULL,
                                   choices = c("Small", "Medium", "Large"),
                                   selected = "Small",
                                   width = "150px"
                                 )
                        ),
                        checkboxInput("high_contrast","High Contrast",FALSE),
                        checkboxInput("reduce_motion","Reduce Motion",FALSE),
                        checkboxInput("readable_font","Readable Font",FALSE),
                        br(),
                        actionButton("reset_accessibility","Reset Settings",class="btn btn-sm btn-secondary")
               )
      ),
      
      div(class="site-header",div(class="eyebrow","Neurodiversity-Inclusive Academic Toolkit")),
      
      tabsetPanel(id="main_tabs",
                  tabPanel("🔍 About",
                           uiOutput("about_ui")
                  ),
                  tabPanel("🧠 Toolkit",
                           div(class="site-header",
                               tags$h1("What's been hard lately?"),
                               div(class="subtitle","Find strategies designed for how your brain actually works.")                           ),
                           uiOutput("home_ui"),
                           uiOutput("cluster_header_ui"),
                           uiOutput("cluster_causes_ui")
                  ),
                  
                  
                  tabPanel("🗂️ Priority Matrix",
                           div(class="planning-card",
                               h2(class="planning-title","Priority Matrix"),
                               p(class="planning-sub","Add tasks and drag them into position by urgency and importance. Select a note, then click 'Break Down Task' to open it in the Task Chunker."),
                               fluidRow(
                                 column(8,
                                        textInput("new_matrix_task",NULL,placeholder="Add a task, e.g. Write lit review"),
                                        actionButton("add_matrix_task","Add Sticky Note",class="btn-show-all")
                                 ),
                                 column(4,br(),
                                        actionButton("send_to_chunker","\u2192  Break Down Task",class="btn-show-all")
                                 )
                               ),
                               div(class="priority-matrix-wrapper",
                                   div(class = "priority-matrix", id = "priority_matrix",
                                       div(class = "matrix-line-vertical"),
                                       div(class = "matrix-line-horizontal"),
                                       # Quadrant meaning labels (in addition to axis labels)
                                       div(class = "quadrant-label q1", "Do First"),       # top-right
                                       div(class = "quadrant-label q2", "Schedule"),        # top-left
                                       div(class = "quadrant-label q3", "Delegate"),        # bottom-right
                                       div(class = "quadrant-label q4", "Let Go"),          # bottom-left
                                       div(class = "matrix-label label-top", "HIGH IMPORTANCE"),
                                       div(class = "matrix-label label-bottom", "LOW IMPORTANCE"),
                                       div(class = "matrix-label label-left", "LOW URGENCY"),
                                       div(class = "matrix-label label-right", "HIGH URGENCY"),
                                       uiOutput("sticky_notes_ui"),
                                       uiOutput("matrix_hint_bar")
                                   )
                               )
                           )
                  ),

                  tabPanel("🪜 Task Chunker",
                           uiOutput("chunker_ui")
                  ),
                  
                  tabPanel("📎 Resources",uiOutput("resources_ui"))
      )
  )
)


server <- function(input, output, session) {
  generate_local_chunk_plan <- function(task, time_av = "30 min", energy = "Medium", deadline = "Due this week", blocker = "") {
    
    task <- trimws(task)
    blocker <- trimws(blocker)
    
    step_count <- switch(
      energy,
      "Low" = 3,
      "Medium" = 4,
      "High" = 5,
      4
    )
    
    step_minutes <- switch(
      time_av,
      "15 min" = c(3, 4, 5),
      "30 min" = c(5, 7, 8, 10),
      "1 hour" = c(8, 10, 12, 15, 15),
      "2+ hours" = c(10, 15, 20, 20, 25),
      c(5, 7, 8, 10)
    )
    
    first_step <- switch(
      energy,
      "Low" = paste("Open what you need for", task, "and write one messy bullet point."),
      "Medium" = paste("Set a 5-minute timer and gather the materials for", task, "."),
      "High" = paste("Open everything for", task, "and sketch a rough plan."),
      paste("Open what you need for", task, ".")
    )
    
    reframe <- if (nzchar(blocker)) {
      paste0("It makes sense this feels hard when ", tolower(blocker), ". You only need to do one small step right now.")
    } else {
      "You do not need to finish everything right now — you just need a manageable place to begin."
    }
    
    note <- switch(
      deadline,
      "Due today" = "Focus on momentum over perfection — done is more useful than perfect.",
      "Due this week" = "Small progress now will make this feel much lighter later.",
      "No rush" = "You are allowed to do this slowly and make it easier on yourself.",
      "Small progress still counts."
    )
    
    step_templates <- list(
      paste("Open the file, tab, or materials for", task),
      "Make a rough bullet outline without worrying about quality",
      "Do the smallest concrete part first",
      "Pause and decide what the next smallest action is",
      "Complete one more short, specific section"
    )
    
    tip_templates <- c(
      "",
      "Messy is completely okay here.",
      "",
      "If you feel stuck, make the step smaller.",
      ""
    )
    
    steps <- lapply(seq_len(step_count), function(i) {
      list(
        action = step_templates[[i]],
        minutes = step_minutes[[min(i, length(step_minutes))]],
        tip = tip_templates[[i]]
      )
    })
    
    # Slightly customize based on task keywords
    task_lower <- tolower(task)
    icon <- "📋"
    
    if (grepl("essay|paper|write|writing|draft", task_lower)) {
      icon <- "✍️"
      steps[[1]]$action <- paste("Open your document for", task)
      steps[[2]]$action <- "Write a rough outline or list 3 points you want to cover"
      steps[[3]]$action <- "Draft the easiest sentence or paragraph first"
    } else if (grepl("study|exam|test|quiz|review", task_lower)) {
      icon <- "📚"
      steps[[1]]$action <- paste("Open your notes or study materials for", task)
      steps[[2]]$action <- "List the top 3 topics you most need to review"
      steps[[3]]$action <- "Study just one topic using notes, flashcards, or practice questions"
    } else if (grepl("email|message", task_lower)) {
      icon <- "📧"
      steps[[1]]$action <- paste("Open your email draft for", task)
      steps[[2]]$action <- "Write a very rough version with the main point only"
      steps[[3]]$action <- "Add greeting, details, and a closing sentence"
    } else if (grepl("laundry|clean|tidy|room|dishes", task_lower)) {
      icon <- "🧺"
      steps[[1]]$action <- paste("Gather what you need to start:", task)
      steps[[2]]$action <- "Do one clearly defined part first"
      steps[[3]]$action <- "Set a short timer and keep going until it ends"
    } else if (grepl("read|chapter|article", task_lower)) {
      icon <- "📖"
      steps[[1]]$action <- paste("Open the reading for", task)
      steps[[2]]$action <- "Skim headings or the first page to get oriented"
      steps[[3]]$action <- "Read one short section and jot down 1–2 notes"
    }
    
    list(
      icon = icon,
      reframe = reframe,
      first_step = first_step,
      steps = steps,
      note = note
    )
  }
  selected_cluster     <- reactiveVal(NULL)
  show_all_state       <- reactiveVal(FALSE)
  brain_tasks          <- reactiveVal(NULL)
  selected_focus_task  <- reactiveVal(NULL)
  chunker_prefill      <- reactiveVal(NULL)
  chunker_result       <- reactiveVal(NULL)
  chunker_loading      <- reactiveVal(FALSE)
  chunker_error        <- reactiveVal(NULL)
  chunker_submitted_task <- reactiveVal(NULL)  # store task name at submit time
  
  matrix_tasks <- reactiveVal(data.frame(
    id=character(),label=character(),x=numeric(),y=numeric(),stringsAsFactors=FALSE
  ))
  
  observe({
    toggleClass(selector = "body", class = "high-contrast", condition = isTRUE(input$high_contrast))
    toggleClass(selector = "body", class = "reduce-motion", condition = isTRUE(input$reduce_motion))
    toggleClass(selector = "body", class = "readable-font", condition = isTRUE(input$readable_font))
    
    font_scale <- input$font_scale %||% "Small"
    if (length(font_scale) != 1 || !font_scale %in% c("Small", "Medium", "Large")) {
      font_scale <- "Small"
    }
    
    size <- switch(
      font_scale,
      "Small" = "14px",
      "Medium" = "18px",
      "Large" = "22px"
    )
    
    session$sendCustomMessage("setFontScale", list(size = size))
  })
  
  observeEvent(input$reset_accessibility,{
    updateCheckboxInput(session,"high_contrast",value=FALSE)
    updateCheckboxInput(session,"reduce_motion",value=FALSE)
    updateCheckboxInput(session,"readable_font",value=FALSE)
    shinyjs::runjs("
    var fs = document.getElementById('font_scale');
    fs.value = 'Small';
    fs.dispatchEvent(new Event('change', {bubbles: true}));
  ")
  })
  
  observeEvent(input$selected_cluster,{
    selected_cluster(input$selected_cluster);show_all_state(FALSE)
    updateCheckboxGroupInput(session,"selected_statements",selected=character(0))
  })
  observeEvent(input$go_home,{selected_cluster(NULL);show_all_state(FALSE)})
  observeEvent(input$show_all,{show_all_state(TRUE)})
  
  selected_causes <- reactive({
    req(selected_cluster())
    cl <- clusters[[selected_cluster()]]
    if(show_all_state()) return(names(cl$causes))
    stmts <- input$selected_statements
    if(is.null(stmts)||!length(stmts)) return(NULL)
    mapped <- cl$statement_map[stmts]
    unique(unlist(mapped[!is.na(mapped)]))
  })
  
  observeEvent(input$add_matrix_task, {
    req(nchar(trimws(input$new_matrix_task)) > 0)
    cur <- matrix_tasks()
    n   <- nrow(cur)
    # Cycle through quadrants: top-right, top-left, bottom-right, bottom-left
    quadrant_x <- c(60, 15, 60, 15)
    quadrant_y <- c(15, 15, 60, 60)
    q <- (n %% 4) + 1
    matrix_tasks(rbind(cur, data.frame(
      id    = paste0("task_", n + 1),
      label = trimws(input$new_matrix_task),
      x     = quadrant_x[q] + sample(-8:8, 1),
      y     = quadrant_y[q] + sample(-8:8, 1),
      stringsAsFactors = FALSE
    )))
    updateTextInput(session, "new_matrix_task", value = "")
  })
  
  observeEvent(input$matrix_drag_update,{
    upd<-input$matrix_drag_update; t<-matrix_tasks()
    idx<-which(t$id==upd$id)
    if(length(idx)>0){
      t$x[idx]<-t$x[idx]+as.numeric(upd$x)/8
      t$y[idx]<-t$y[idx]+as.numeric(upd$y)/8
      matrix_tasks(t)
    }
  })
  
  observeEvent(input$delete_matrix_task, {
    cur <- matrix_tasks()
    matrix_tasks(cur[cur$id != input$delete_matrix_task, ])
    if (!is.null(input$selected_matrix_task) &&
        input$selected_matrix_task == cur$label[cur$id == input$delete_matrix_task]) {
      session$sendCustomMessage("clearSelectedTask", list())
    }
  })
  
  observeEvent(input$send_to_chunker,{
    req(input$selected_matrix_task)
    chunker_prefill(input$selected_matrix_task)
    chunker_result(NULL); chunker_error(NULL); chunker_loading(FALSE)
    updateTabsetPanel(session,"main_tabs",selected="🪜 Task Chunker")
  })
 
  observeEvent(input$chunk_it, {
    task <- trimws(input$chunker_task_input %||% "")
    req(nchar(task) > 0)
    
    chunker_submitted_task(task)
    chunker_result(NULL)
    chunker_error(NULL)
    chunker_loading(TRUE)
    
    time_av  <- input$chunker_time %||% "30 min"
    energy   <- input$chunker_energy %||% "Medium"
    deadline <- input$chunker_deadline %||% "Due this week"
    blocker  <- trimws(input$chunker_blocker %||% "")
    
    result <- tryCatch({
      generate_local_chunk_plan(
        task = task,
        time_av = time_av,
        energy = energy,
        deadline = deadline,
        blocker = blocker
      )
    }, error = function(e) {
      list(error = conditionMessage(e))
    })
    
    chunker_loading(FALSE)
    
    if (!is.null(result$error)) {
      chunker_error(paste("Could not generate a plan:", result$error))
    } else {
      chunker_result(result)
    }
  })
  
  observeEvent(input$chunker_reset, {
    chunker_result(NULL); chunker_error(NULL)
    chunker_loading(FALSE); chunker_prefill(NULL)
    chunker_submitted_task(NULL)
  })
  observeEvent(input$chunker_retry, {
    chunker_result(NULL); chunker_error(NULL)
    shinyjs::delay(50, shinyjs::click("chunk_it"))
  })
  
  output$about_ui <- renderUI({
    div(
      div(class="about-card",
          div(class="about-title","About This Toolkit"),
          div(class="about-sub",
              "This toolkit is designed to help students break through overwhelm, understand what might be getting in the way, and find realistic next steps. You do not need to use every feature — you can start anywhere."),
          div(class="about-note",
              tags$strong("Good place to start: "),
              "If you are not sure what you need, begin with the Toolkit tab. If you already know the task you need to do, try Task Chunker. If everything feels jumbled, try the Priority Matrix tab.")
      ),
      
      div(class="about-card",
          h2(style="font-family:'DM Serif Display',serif;font-size:24px;margin-bottom:16px;","What each tab does"),
          div(class="about-grid",
              div(class="about-feature",
                  span(class="about-feature-icon","🧠"),
                  h3("Toolkit"),
                  p("Choose a topic like getting started, being on time, studying, or keeping track. Then select the statements that sound like you to see possible explanations and strategies.")
              ),
              div(class="about-feature",
                  span(class="about-feature-icon","🪜"),
                  h3("Task Chunker"),
                  p("Type in one task and the app breaks it into smaller, more doable steps. This is helpful when a task feels too big, vague, or hard to begin.")
              ),
              div(class="about-feature",
                  span(class="about-feature-icon","🗂️"),
                  h3("Priority Matrix"),
                  p("Add tasks as sticky notes and place them based on urgency and importance. This helps you see what needs attention now and what can wait.")
              ),
              div(class="about-feature",
                  span(class="about-feature-icon","📎"),
                  h3("Resources"),
                  p("Find worksheets and support materials for planning, emotional regulation, and burnout recovery.")
              )
          )
      ),
      
      div(class="about-card",
          h2(style="font-family:'DM Serif Display',serif;font-size:24px;margin-bottom:16px;","How to use it"),
          tags$ol(class="about-steps",
                  tags$li("Start with the tool that matches what feels hardest right now."),
                  tags$li("If you have one task but cannot start, use Task Chunker."),
                  tags$li("If you have many tasks and do not know what matters most, use Priority Matrix."),
                  tags$li("If you want strategies for a recurring problem, explore the Toolkit tab."),
                  tags$li("Use the Accessibility menu in the top-right corner to adjust contrast, motion, font, and text size.")
          )
      ),
      
      div(class="about-card",
          h2(style="font-family:'DM Serif Display',serif;font-size:24px;margin-bottom:16px;","A reminder"),
          div(class="about-note",
              "This app is meant to support you, not judge you. If something feels difficult, that does not mean you are lazy or failing — it may just mean you need a different structure, a smaller first step, or the right support.")
      )
    )
  })
  output$home_ui <- renderUI({
    req(is.null(selected_cluster()))
    div(class="cluster-grid anim-in",
        lapply(names(clusters),function(name){
          cl <- clusters[[name]]
          tags$button(
            class="cluster-card",
            onclick=sprintf("Shiny.setInputValue('selected_cluster','%s',{priority:'event'})",name),
            tags$span(class="card-icon",cl$icon),
            div(class="card-title",name),
            div(class="card-previews",lapply(cl$preview,tags$span))
          )
        })
    )
  })
  
  output$cluster_header_ui <- renderUI({
    req(!is.null(selected_cluster()))
    cl <- clusters[[selected_cluster()]]
    div(class="anim-in",
        tags$button(class="back-btn",id="go_home",
                    onclick="Shiny.setInputValue('go_home',Math.random())","<- All topics"),
        div(class="cluster-detail-header",
            tags$span(class="cluster-icon-lg",cl$icon),
            tags$h2(selected_cluster()),
            div(class="section-sub","Select what resonates, then explore what might help.")
        ),
        div(class="statements-section",
            tags$h3("Do any of these sound like you?"),
            checkboxGroupInput("selected_statements",NULL,choices=cl$statements),
            div(class="show-all-wrapper",
                div(class="show-all-text","None of these feel right, or want to see everything:"),
                actionButton("show_all","Show all strategies",class="btn-show-all")
            )
        )
    )
  })
  
  output$cluster_causes_ui <- renderUI({
    req(!is.null(selected_cluster()))
    cl <- clusters[[selected_cluster()]]; visible <- selected_causes()
    if(is.null(visible))
      return(div(class="anim-in",style="color:#888;font-size:14px;margin-top:10px;",
                 "Select one or more statements above to see strategies tailored to you."))
    div(class="anim-in",
        div(class="causes-heading","What might be going on"),
        div(class="causes-grid",
            lapply(seq_along(cl$causes),function(i){
              nm <- names(cl$causes)[i]
              if(!(nm %in% visible)) return(NULL)
              cd  <- cl$causes[[i]]
              uid <- gsub("[^a-zA-Z0-9]","_",paste0(selected_cluster(),"_",i))
              div(class="cause-card",
                  div(class="cause-header",
                      onclick=sprintf("document.getElementById('strat_%s').classList.toggle('open');document.getElementById('toggle_%s').classList.toggle('open');",uid,uid),
                      div(class="cause-header-left",
                          div(class="cause-label",cd$label),
                          div(class="cause-title",nm),
                          div(class="cause-plain",cd$plain)
                      ),
                      div(class="cause-toggle",id=paste0("toggle_",uid),"+")
                  ),
                  div(class="cause-strategies",id=paste0("strat_",uid),
                      div(class="strategies-label","Strategies"),
                      tags$ul(class="strategies-list",
                              lapply(cd$strategies,function(x) tags$li(HTML(x))))
                  )
              )
            })
        )
    )
  })
  
  output$sticky_notes_ui <- renderUI({
    tasks <- matrix_tasks()
    if (nrow(tasks) == 0) return(NULL)
    lapply(seq_len(nrow(tasks)), function(i) {
      div(class = "sticky-note", id = tasks$id[i],
          style = paste0("left:", tasks$x[i], "%;top:", tasks$y[i], "%;"),
          onclick = sprintf(
            "$('.sticky-note').removeClass('selected');$(this).addClass('selected');
           Shiny.setInputValue('selected_matrix_task','%s',{priority:'event'});",
            gsub("'", "\\\\'", tasks$label[i])),
          tasks$label[i],
          tags$button(
            class = "sticky-delete",
            onclick = sprintf(
              "event.stopPropagation();Shiny.setInputValue('delete_matrix_task','%s',{priority:'event'});",
              tasks$id[i]),
            HTML("&times;")
          )
      )
    })
  })
  
  output$matrix_hint_bar <- renderUI({
    task <- input$selected_matrix_task
    if(is.null(task)||nchar(task)==0) return(NULL)
    div(class="matrix-hint",
        tags$strong("Selected: "),task,
        tags$span(style="color:#888;margin-left:12px;font-size:12px;",
                  "Click '\u2192 Break Down Task' to build a step plan"))
  })
  
  output$chunker_ui <- renderUI({
    
    if(isTRUE(chunker_loading())) {
      return(div(class="planning-card",
                 div(class="chunker-loading",
                     div(class="chunker-spinner"),
                     div(class="chunker-loading-text","Building your personalised plan\u2026")
                 )
      ))
    }
    
    err <- chunker_error()
    if(!is.null(err)) {
      return(div(class="planning-card",
                 div(class="chunker-error", icon("exclamation-triangle"), " ", err),
                 br(),
                 actionButton("chunker_reset","Try a different task",class="btn-ghost")
      ))
    }
    
    result <- chunker_result()
    if(!is.null(result)) {
      return(chunker_results_ui(result, chunker_submitted_task()))
    }
    
    prefill <- chunker_prefill() %||% ""
    
    div(class="planning-card anim-in",
        div(class="planning-title","Task Chunker"),
        div(class="planning-sub",
            "Tell me what you need to do and I'll break it into steps sized for where you're at right now."),
        
        div(class="chunker-form",
            
            div(class="chunker-field",
                tags$label("What's the task?"),
                textInput(
                  "chunker_task_input",
                  label = NULL,
                  value = prefill,
                  placeholder = "e.g. Write the introduction to my essay",
                  width = "100%"
                )
            ),
            
            div(class="chunker-field",
                tags$label(HTML("What's making it hard? <span style='font-weight:300;color:#bbb;text-transform:none;letter-spacing:0'>(optional)</span>")),
                textAreaInput(
                  "chunker_blocker",
                  label = NULL,
                  value = "",
                  rows = 2,
                  width = "100%",
                  placeholder = "e.g. I don't know where to start, it feels too big, I'm scared of getting it wrong…"
                )
            ),
            
            div(class="chunker-field",
                tags$label("How long do you have right now?"),
                div(class="pill-group",
                    radioButtons("chunker_time",NULL,inline=TRUE,
                                 choices=c("15 min","30 min","1 hour","2+ hours"),
                                 selected="30 min")
                )
            ),
            
            div(class="chunker-field",
                tags$label("Energy level right now?"),
                div(class="pill-group",
                    radioButtons("chunker_energy",NULL,inline=TRUE,
                                 choices=c("Low","Medium","High"),
                                 selected="Medium")
                )
            ),
            
            div(class="chunker-field",
                tags$label("How urgent is this?"),
                div(class="pill-group",
                    radioButtons("chunker_deadline",NULL,inline=TRUE,
                                 choices=c("Due today","Due this week","No rush"),
                                 selected="Due this week")
                )
            ),
            
            actionButton(
              "chunk_it",
              label = "Break it down \u2192",
              class = "btn-chunker-submit"
            )
        )
    )
  })
  
  # Init pills after render
  observe({
    req(is.null(chunker_result()))
    req(!isTRUE(chunker_loading()))
    session$sendCustomMessage("initPills", list())
  })
  
  chunker_results_ui <- function(result, task_name) {
    steps <- result$steps
    n     <- length(steps)
    
    step_items <- lapply(seq_along(steps), function(i) {
      s   <- steps[[i]]
      tip <- if(!is.null(s$tip) && nchar(trimws(s$tip))>0)
        tags$div(class="step-tip", s$tip) else NULL
      div(class="step-item",
          div(class="step-checkbox", tags$span(class="step-checkmark","\u2713")),
          div(class="step-body",
              div(class="step-action", s$action),
              div(class="step-meta",
                  tags$span(class="step-time", paste0("~",s$minutes," min")),
                  tip)
          )
      )
    })
    
    icon_char <- result$icon %||% "📋"
    
    div(class="chunker-results",
        div(class="planning-card",
            
            div(class="chunker-task-header",
                div(class="chunker-task-icon", icon_char),
                div(
                  div(class="chunker-task-name", task_name %||% "Your task"),
                  div(class="chunker-reframe", result$reframe)
                )
            ),
            
            div(class="chunker-progress-wrap",
                div(class="chunker-progress-label",
                    tags$span("Steps completed"),
                    tags$span(class="chunker-progress-count", paste0("0 / ",n," done"))
                ),
                div(class="chunker-progress-track",
                    div(class="chunker-progress-fill"))
            ),
            
            div(class="first-step-card",
                tags$span(class="first-step-badge","START HERE"),
                div(class="first-step-text", result$first_step)
            ),
            
            div(class="step-list", step_items),
            
            tags$div(id="chunker-celebration", style="display:none;",
                     div(class="chunker-done",
                         tags$span(class="chunker-done-emoji","🎉"),
                         tags$h3("You did it."),
                         tags$p("Every step taken is real progress. Take a breath — you earned it.")
                     )
            ),
            
            div(class="chunker-note",
                tags$strong("A note: "), result$note),
            
            div(class="chunker-actions",
                actionButton("chunker_reset",  "Try a different task",       class="btn-ghost"),
                actionButton("chunker_retry",  "Get a different breakdown",  class="btn-ghost")
            )
        )
    )
  }
  
  output$resources_ui <- renderUI({
    div(
      div(class="planning-card",h3(style="margin-bottom:16px;","Planning"),
          tags$ul(class ="planning-list",
            style="padding-left:20px;line-height:2.2;",
                  tags$li(tags$a(href="semester-planning.xlsx","Semester Planning Spreadsheet")),
                  tags$li(tags$a(href="backwards-planning-worksheet.pdf","Backward Planning Worksheet")),
                  tags$li(tags$a(href="adhd-daily-planner-layout-sampler-pack.pdf","Sample Daily Planners")),
                  tags$li(tags$a(href="adhd-focus-plan-breaking-down-tasks.pdf","Focus Plan with Task Chunking")),
                  tags$li(tags$a(href="goal-breakdown.pdf","Goal Breakdown")),
                  tags$li(tags$a(href="EisenhowerMatrix.pdf","Priority Matrix Handout")),
                  tags$li(tags$a(href="https://excel.cloud.microsoft/create/en/gantt-charts/", "Gantt Chart Templates"))
          )
      ),
      div(class="planning-card",h3(style="margin-bottom:16px;","Emotional Regulation"),
          tags$ul(class ="planning-list",
                  style="padding-left:20px;line-height:2.2;",
                  tags$li(tags$a(href="Grounding+Exercise+FINAL.pdf","Grounding Exercise (5-4-3-2-1)")),
                  tags$li(tags$a(href="breathing-exercises.pdf","Breathing Exercises")),
                  tags$li(tags$a(href="bNeurodiversityHub___Managing+Anxiety_v2.pdf","Managing Anxiety"))
          )
      ),
            div(class="planning-card",h3(style="margin-bottom:16px;","Burnout and Wellness"),
          tags$ul(class ="planning-list",
                  style="padding-left:20px;line-height:2.2;",
                  tags$li(tags$a(href="dopamine-menu.pdf","Dopamine Menu")),
                  tags$li(tags$a(href="Burnout+and+ADHD.pdf","ADHD and Burnout Handout")),
                  tags$li(tags$a(href="Self+Care+with+ADHD.pdf","ADHD Self Care Handout")),
                  tags$li(tags$a(href="reclaimingsolidground_worksheet1.pdf","Burnout Journaling Activity")),
                  tags$li(tags$a(href="Sensory-Overwhelm.pdf","Sensory Overwhelm Worksheet"))
          )
          ),
          div(class="planning-card",h3(style="margin-bottom:16px;","Academic"),
              tags$ul(class ="planning-list",
                      style="padding-left:20px;line-height:2.2;",
                      tags$li(tags$a(href="Student Email Guide.docx","Templates for Emailing Professors/TAs")),
                      tags$li(tags$a(href="Studying+with+ADHD.pdf","Tips for Studying with ADHD")),
                      tags$li(tags$a(href="study-tips.pdf","General Study Tips")),
                      tags$li(tags$a(href="How-to-Get-ADHD-Accommodations-in-College-1.pdf", "Info on College Accommodations"))
              )
      )
    )
  })
}

shinyApp(ui, server)
