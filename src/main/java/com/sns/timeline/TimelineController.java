package com.sns.timeline;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
	@GetMapping("/list_view")
	public String timelineListView(Model model) {
		model.addAttribute("view", "timeline/timelineList");
		return "template/layout";
	}
	
}
