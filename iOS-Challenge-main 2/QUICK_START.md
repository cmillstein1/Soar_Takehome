# Quick Start Guide

## For Candidates

### 1. Get the App Running

```bash
git clone [this-repo]
cd "Soar iOS challenge"
open "Soar iOS challenge.xcodeproj"
```

Hit `Cmd+R` to run - you should see a single card in the center of the screen.

### 2. Pick Your Animation Challenge

Choose **ONE** and implement it perfectly:

**🎯 Option 1: Flip Card**

- 3D rotation animation
- Switch between front/back content
- Smooth physics and perspective

**🎯 Option 2: Swipe Actions**

- Pan gesture to reveal actions
- Spring physics with snap-back
- Rubber-band effect

**🎯 Option 3: Expandable Card**

- Tap to scale up/down
- Show/hide detailed content
- Background dimming

### 3. Where to Start

Look for `TODO` comments in:

- `MainViewController.swift` - Main interaction setup
- `CardView.swift` - Card component
- `CardAnimations.swift` - Animation utilities

### 4. Pro Tips

- Focus on ONE animation - make it perfect
- Test on device for real performance
- Start with basic gesture, then add animation
- Use the provided spring animation helper

---

## For Interviewers

### Setup

1. Push this repo to GitHub (public/private)
2. Test that it builds and runs (shows single card)
3. Send repo link to candidate

### What to Look For

- **Animation quality** - smooth, natural feeling
- **Code organization** - clean, readable implementation
- **Performance** - maintains 60fps
- **Polish** - handles edge cases and interruptions

### Timing

- **2 hours max** - enforce strictly
- **Quality over quantity** - one excellent animation beats multiple poor ones

### Quick Evaluation

1. Does the animation feel smooth and natural?
2. Is the code well structured and readable?
3. Do they handle gesture edge cases properly?
4. Would this be production-ready?

---

**Simple, focused, effective!** ✨
