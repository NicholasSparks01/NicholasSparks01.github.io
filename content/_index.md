---
title: Nicholas Sparks
layout: hextra-home
---

{{< hextra/hero-badge link="blog" >}}
  <div class="hx:w-2 hx:h-2 hx:rounded-full hx:bg-primary-400"></div>
  <span>Vulnerability Research · Reverse Engineering</span>
  {{< icon name="arrow-circle-right" attributes="height=14" >}}
{{< /hextra/hero-badge >}}

<div class="hx:mt-6 hx:mb-6">
{{< hextra/hero-headline >}}
  Security Research
{{< /hextra/hero-headline >}}
</div>

<div class="hx:mb-12">
{{< hextra/hero-subtitle >}}
  Technical write-ups on finding, understanding,&nbsp;<br class="hx:sm:block hx:hidden" />and exploiting bugs in real software.
{{< /hextra/hero-subtitle >}}
</div>

<div class="hx:mb-6 hx:flex hx:gap-3 hx:flex-wrap">
{{< hextra/hero-button text="Read the Blog" link="blog" >}}
{{< hextra/hero-button text="Browse Notes" link="notes" style="background: transparent; color: inherit; border: 1px solid rgba(127,127,127,.35);" >}}
</div>

<h2 class="ns-section-title">Latest posts</h2>

{{< recent-posts count=5 >}}

{{< hextra/feature-grid >}}
  {{< hextra/feature-card
    title="Vulnerability Research"
    subtitle="Root-cause analysis, advisories, and exploit development for bugs found in the wild."
    link="notes/vulnerability-research"
    icon="shield-exclamation"
  >}}
  {{< hextra/feature-card
    title="Reverse Engineering"
    subtitle="Binary analysis, firmware teardown, protocol reversing, and tooling."
    link="notes/reverse-engineering"
    icon="chip"
  >}}
  {{< hextra/feature-card
    title="Research Notes"
    subtitle="A living, searchable knowledge base of techniques, cheat sheets, and references."
    link="notes"
    icon="book-open"
  >}}
{{< /hextra/feature-grid >}}
