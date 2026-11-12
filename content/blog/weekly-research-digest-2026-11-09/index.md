---
title: "Weekly Research Digest: Week of November 9, 2026"
date: 2026-11-11T18:39:17-05:00
draft: false
description: "10 new arXiv papers on reverse engineering, vulnerability research and AI-assisted security from October 10 to November 8, 2026, led by CyberBinGym, ATLAS, Rethinking Neural Decompilation."
tags:
  - "Research Digest"
  - "arXiv"
  - "Reverse Engineering"
  - "Vulnerability Research"
  - "AI/LLM"
authors:
  - name: "Nicholas Sparks"
    link: "https://github.com/NicholasSparks01"
    image: "https://github.com/NicholasSparks01.png"
digest:
  run_id: 5
  window: "October 10 to November 8, 2026"
---

This digest covers **10 papers** submitted to arXiv from October 10 to November 8, 2026, chosen for reverse engineering, binary analysis, vulnerability research and AI-assisted security tooling.

<!--more-->

{{< callout type="info" >}}
**AI-assisted analysis.** A local language model selected, summarised and compared these papers. For papers marked *PDF analyzed*, the numbers under *Key results* were checked against the paper's PDF and their page references point to where they appear. This is not independent academic peer review: summaries and interpretations can be incomplete or wrong, so read the original paper before relying on a finding.
{{< /callout >}}

## Research overview

- **Papers collected:** 12,477
- **Abstracts screened:** 3,557 checked for relevance; the top 300 screened in detail
- **PDFs analyzed:** 10 of the 10 selected papers (15 in total)
- **Papers selected:** 10
- **Annotated PDFs:** 10 of 10 papers
- **arXiv categories represented:** cs.CR (6), cs.SE (4)

## Highlights

*Findings reported by the papers themselves.*

- **AI agents recover vulnerabilities from binaries but struggle with exploitation**: CyberBinGym demonstrates that frontier models can reliably recover real-world vulnerabilities from binary diffs using only stripped binaries, but end-to-end exploitation is much harder: exploit rates were 0-20% against vulnerability-recovery rates of 64-88% across the three agents tested. ([#1](#paper-1))
- **Neural decompilation is bottlenecked by candidate selection, not generation**: Rethinking Neural Decompilation shows that correct code often exists within the top-5 sampling space of models, but greedy decoding fails to retrieve it; execution-guided selection and negative perplexity scoring effectively recover these hidden candidates. ([#3](#paper-3))
- **Decompilation quality does not correlate with vulnerability detection accuracy**: VulDec finds that high Edit Similarity in decompiled code does not strongly predict successful vulnerability detection, suggesting detectors rely on specific syntactic patterns rather than high-level semantic fidelity. ([#4](#paper-4))
- **LLM agents significantly outperform static baselines in protocol reverse engineering**: SEMPRE integrates dynamic taint analysis with recursive LLM reasoning to achieve an average F1 of 0.76 for field detection, vastly outperforming state-of-the-art tools that average below 0.40. ([#6](#paper-6))
- **Semantic-aware rewriting accelerates program reduction without sacrificing precision**: Scythe acts as a pre-processing step for grammar-based reducers, producing strictly smaller programs in 70 of 73 benchmarks and speeding up reduction by 2.3× on average. ([#8](#paper-8))

## Ranked research index

**Rank** is this digest's order. The model compared the shortlisted papers about ten at a time, using summaries of their abstracts, before any PDF was read. **Score** is the paper's own result out of 100 on a fixed rubric (topic alignment 30, applicability 25, cross-domain relevance 15, novelty 15, reproducibility 15), updated after its PDF was analyzed; the label is the score's range (Critical ≥ 85, High ≥ 70, Medium ≥ 50, Low ≥ 40). Rank and score come from different steps, so a paper can rank above one with a higher score.

| Rank | Paper | Area | Score (of 100) |
|--:|---|---|---|
| 1 | [CyberBinGym: Can AI Agents Turn Binary Patches into Real Exploits?](#paper-1) | cs.CR | 75 · High |
| 2 | [ATLAS: A Multi-Agent Framework for Lifting Binary to Canonical Compiler IR](#paper-2) | cs.SE | 85 · Critical |
| 3 | [Rethinking Neural Decompilation: Candidate Selection as the Hidden Bottleneck](#paper-3) | cs.CR | 81 · High |
| 4 | [VulDec: Vulnerability Detection in Binaries via Neural Decompilation](#paper-4) | cs.CR | 75 · High |
| 5 | [Locate, Then Reason: End-to-End Patch Presence Testing in Stripped Binaries](#paper-5) | cs.CR | 75 · High |
| 6 | [SEMPRE: Semantic-Aware Protocol Reverse Engineering via Consistency-Driven Joint Optimization](#paper-6) | cs.CR | 79 · High |
| 7 | [JANUS: Agentic Cross-Language Fuzzing Harness Generation for Android Native Libraries](#paper-7) | cs.SE | 80 · High |
| 8 | [Scythe: Semantic-Aware Rewriting for Fast,Effective Program Reduction](#paper-8) | cs.SE | 81 · High |
| 9 | [PhotoFinish: Portable Timerless Probing of Microarchitectural Latencies](#paper-9) | cs.CR | 91 · Critical |
| 10 | [APG: Agentic Static-Analysis Infrastructure on LLVM-IR Graph Databases](#paper-10) | cs.SE | 79 · High |

## Paper analyses

### 1. CyberBinGym: Can AI Agents Turn Binary Patches into Real Exploits? {#paper-1}

**Rank 1** · Score **75/100** (High) · cs.CR · PDF analyzed · [arXiv](https://arxiv.org/abs/2611.10723) · [PDF](https://arxiv.org/pdf/2611.10723) · [Annotated PDF](2611.10723-annotated.pdf)

The paper introduces CYBERBINGYM, a benchmark evaluating AI agents' ability to recover and exploit real-world vulnerabilities using only stripped vulnerable and patched binaries (the '1-day setting'). It demonstrates that frontier models can reliably recover vulnerabilities from binary diffs but struggle significantly with end-to-end exploitation. The study shows that access to the patched binary provides actionable information for attackers, increasing exploit rates, even when standard hardening protections are enabled.

**Reader takeaway:** Researchers should expect AI agents to successfully identify vulnerabilities from binary diffs but should not expect reliable automated exploitation: in this benchmark, exploit rates were far below vulnerability-recovery rates.

**Why it stands out:** The paper demonstrates that AI agents can effectively use binary patch diffs to localize vulnerabilities and construct exploits, challenging the assumption that patches are purely defensive. It highlights a significant capability gap between triggering a crash (vulnerability recovery) and achieving code execution (exploitation). The study also evaluates the impact of standard hardening techniques like stack canaries and PIE on agent success.

**Key results** (numbers checked against the PDF):

- **CYBERBINGYM (100 tasks)**, Recover Vuln. rate / Exploit rate: Codex: 88% / 20%; Claude: 85% / 6%; Kimi: 64% / 0% (p. 6)
- **Matched 20-task subset**, Valid-PoC (vulnerability recovered) rate / Exploit rate / Cost: Vulnerable binary only: 55% / 10%; Vulnerable and patched binaries: 90% / 25%. Average cost: &#36;36.59 -&gt; &#36;31.42. (p. 9, 18)
- **Matched 50-task subset**, Recover Vuln. rate / Exploit rate: Codex (no desc): 90% / 24%; With desc: 86% / 20%. Kimi (no desc): 64% / 0%; With desc: 70% / 1 exploit. (p. 9, 18)
- **20 tasks, 3 attempts each**, Success@k (Recover Vuln / Exploit): k=1: 68.3% / 11.7%; k=2: 83.3% / 20.0%; k=3: 90.0% / 25.0%. (p. 9)
- **20 tasks Codex exploited in the main run, rebuilt with standard hardening**, Recover Vuln. rate / Exploit rate: Recovered 15 vulnerabilities, completed only 2 exploits. (p. 10)

*Metrics:* **Success@k** is the share of tasks solved in at least one of k independent attempts.

**Related tools and projects** (cited by the paper, not its implementation): [UKGovernmentBEIS/inspect&#95;ai](https://github.com/UKGovernmentBEIS/inspect_ai), [google/oss-fuzz](https://github.com/google/oss-fuzz), [radareorg/radare2](https://github.com/radareorg/radare2)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** AI agents can recover real-world vulnerabilities from binary-only analysis in high rates, but exploitation remains significantly harder. (p. 2, 6)
- **Demonstrated:** Providing the patched binary to an agent increases its ability to exploit a vulnerability compared to having only the vulnerable binary. (p. 2, 9)
- **Demonstrated:** Standard binary hardening techniques (stack canaries, PIE, RELRO) reduce but do not eliminate the ability of AI agents to exploit vulnerabilities. (p. 10)
- **Demonstrated:** Vulnerability descriptions provided to the agent do not reliably improve overall success rates and can sometimes hinder performance. (p. 9)
- **Limitation** (stated by the authors): The evaluation uses historical vulnerabilities and controlled victim services; it does not directly measure production compromise rates or the time to exploit newly released patches in deployed systems.
- **Limitation** (stated by the authors): The aggregate difference in hardening results includes agent search variation and service-delivery failures, so it does not isolate the effect of hardening alone.
- **Method:** The authors constructed a benchmark of 100 tasks derived from real vulnerabilities in 53 open-source projects. Each task provides stripped vulnerable and patched binaries without source code or vulnerability descriptions. Agents interact with static analysis tools (Ghidra, Radare2), dynamic debuggers (GDB, Valgrind), and a victim service to recover crashes and retrieve flags. Success is validated via differential crash testing against sanitizer-instrumented builds and flag retrieval verified by trajectory audits.
- **Relevance** (Agentic reverse engineering pipeline): The paper directly evaluates agentic reverse engineering capabilities on binary-only inputs, providing a benchmark for the 'Agentic reverse engineering pipeline' project.
- **Relevance** (Binary triage and evidence-based analysis): CYBERBINGYM provides a structured set of tasks with differential crash validation and trajectory audits, suitable for 'Binary triage and evidence-based analysis'.
- **Relevance** (Local model and agent architecture): The study uses frontier models (GPT-5.6, Claude Opus 5) but discusses the implications of local inference constraints and deployment delays, relevant to 'Local model and agent architecture'.
- **Editorial correction:** The hardening results (stack canaries, PIE, full RELRO, non-executable stack, Fortify) are on printed page 10, not page 9.
- **Editorial correction:** The hardened re-evaluation (15 vulnerabilities recovered, 2 exploits) is on printed page 10 and uses binaries rebuilt with standard hardening.
- **Editorial correction:** Figure 5 labels the conditions 'Vulnerable only' and '+ Patched binary'; the first rate is the share of tasks with a valid proof-of-concept crash. The numbers are on page 9.
- **Editorial correction:** The patched-binary result is stated on page 2 and analysed on page 9 (Figure 5); page 7 does not discuss it.
- **Editorial correction:** The vulnerability-description results (Figure 4) are on page 9; page 8 does not mention descriptions.

{{< /details >}}

### 2. ATLAS: A Multi-Agent Framework for Lifting Binary to Canonical Compiler IR {#paper-2}

**Rank 2** · Score **85/100** (Critical) · cs.SE · PDF analyzed · [arXiv](https://arxiv.org/abs/2610.30877) · [PDF](https://arxiv.org/pdf/2610.30877) · [Annotated PDF](2610.30877-annotated.pdf)

The paper presents ATLAS, a multi-agent framework for lifting stripped, optimized binaries to canonical LLVM IR. It combines structure-aware retrieval (using pseudo-probe attribution to align assembly regions with IR exemplars) and an iterative repair loop (ADVISOR/VALIDATOR agents) that uses compiler diagnostics and behavioral tests to refine the lift. Experiments on HumanEval-Decompile and MBPP across x86-64, ARM64, and RISC-V show ATLAS achieving 91.8% re-executability and 89.4% CFG similarity on average, outperforming rule-based lifters (RetDec) and general-purpose LLMs. The work also demonstrates improved downstream analyzability (SVF PCI) and cross-ISA migration.

**Reader takeaway:** ATLAS provides a robust framework for lifting optimized binaries to canonical LLVM IR across multiple ISAs, enabling downstream analysis that rule-based tools cannot achieve.

**Why it stands out:** The use of pseudo-probe instrumentation to maintain region-level alignment between assembly and IR despite aggressive optimizations is a novel contribution for binary lifting. The multi-agent repair loop that maps diagnostics to localized IR slices (phi, type, def-use) and uses behavioral harnesses derived from the original binary (without source tests) is also significant.

**Key results** (numbers checked against the PDF):

- **HumanEval-Decompile (164 programs), MBPP (500 programs)**, Re-compilability, Re-executability, Edit Similarity: ATLAS: 99.2% re-compilability / 94.5% re-executability / 51.4% edit similarity (x86-64 HumanEval-Decompile); 98.8% / 94.2% / 44.3% (ARM64); 97.8% / 80.6% / 51.8% (RISC-V). MBPP (x86-64): 98.7% / 95.4% / 50.2%. All figures are averages over optimization levels -O0 to -O3. (p. 8)
- **HumanEval-Decompile**, CFG full-match accuracy, CFG similarity: ATLAS: 26.9% full-match / 97.8% similarity (x86-64); 18.3% / 84.1% (ARM64); 20.1% / 90.2% (RISC-V). (p. 9)
- **HumanEval-Decompile (x86-64)**, Re-compilability, Re-executability, Edit Similarity: Control-flow level: 87.8% re-comp / 56.9% re-exec / 51.0% edit-sim; Basic-block: 68.4% / 49.2% / 44.8%; Function-level: 84.1% / 54.4% / 46.9%. (p. 10)
- **HumanEval-Decompile (x86-64)**, Re-compilability, Re-executability, Edit Similarity: Without loop: 87.8% / 56.9% / 51.0%; With loop: 99.2% / 94.5% / 51.4%. (p. 10)
- **HumanEval-Decompile**, SVF completion, Avg. alias set size, PCI: ATLAS: 85.5% completion / 1.00 avg alias set / 132.9 PCI; RetDec: 82.5% / 1.03 / 107.1; LLM4Decompile+clang: 81.7% / 1.05 / 80.4. (p. 11)

*Metrics:* **Re-executability** is the share of outputs that recompile and pass the benchmark's original tests; **Re-compilability** is the share of outputs that compile without errors; **Edit similarity** is the closeness to the reference output from normalised edit distance; 100% means identical; **CFG similarity and full match** is the how closely the recovered control-flow graph matches the reference; a full match means the two graphs are identical.

**Related tools and projects** (cited by the paper, not its implementation): [llvm/llvm-project](https://github.com/llvm/llvm-project), [lifting-bits/mcsema](https://github.com/lifting-bits/mcsema)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** ATLAS lifts stripped, optimized binaries to canonical LLVM IR with high re-executability and CFG similarity across x86-64, ARM64, and RISC-V. (p. 2, 8)
- **Demonstrated:** Structure-aware retrieval using pseudo-probe attribution improves lifting quality under aggressive optimizations compared to basic-block or function-level retrieval. (p. 5, 9)
- **Demonstrated:** The ADVISOR–VALIDATION refinement loop substantially improves re-executability and re-compilability without materially changing edit similarity. (p. 9)
- **Demonstrated:** ATLAS outperforms rule-based lifters (RetDec) and general-purpose LLMs on re-executability, CFG similarity, and downstream analyzability (SVF PCI). (p. 8, 11)
- **Limitation** (stated by the authors): Behavioral feedback relies on available test inputs and harnesses; binary-only settings without tests require constructing harnesses via static interface inference and dynamic instrumentation, which may be incomplete.
- **Limitation** (stated by the authors): Exact CFG recovery is challenging under aggressive optimizations due to transformations like if-conversion and block merging; ATLAS achieves partial CFG similarity rather than exact match in many cases.
- **Limitation** (stated by the authors): Evaluation focuses on x86-64, ARM64, and RISC-V; generalization to other ISAs or proprietary binaries is not assessed.
- **Method:** ATLAS lifts optimized binaries to canonical LLVM IR via: (1) disassembly with llvm-objdump; (2) CFG recovery with angr and region-level segmentation; (3) retrieval of aligned assembly–IR exemplars from a structure-aware RAG database using Nova-1.3B embeddings; (4) initial IR synthesis by an LLM conditioned on retrieved exemplars; (5) ADVISOR agent localizes errors via LLVM verifier/static analyzer diagnostics and proposes repairs; (6) VALIDATION agent applies edits, re-runs verification and behavioral tests, feeding back to ADVISOR up to five iterations. The RAG database is built from ExeBench with pseudo-probe instrumentation to preserve region boundaries under optimization.
- **Relevance** (Agentic reverse engineering pipeline): ATLAS is a concrete agentic reverse engineering pipeline that separates synthesis, repair planning, and validation—directly applicable to building an agentic RE system.
- **Relevance** (Binary triage and evidence-based analysis): The framework provides structured diagnostics (error categories, localized slices) suitable for triage-based analysis of lifted IR quality.
- **Relevance** (Local model and agent architecture): ATLAS uses Nova-1.3B with LoRA adaptation for ARM64/RISC-V; this aligns with local model optimization and cross-ISA adaptation.
- **Editorial correction:** The MBPP figures (98.7 / 95.4 / 50.2) are from the x86-64 block of Table III, averaged over -O0 to -O3.

{{< /details >}}

### 3. Rethinking Neural Decompilation: Candidate Selection as the Hidden Bottleneck {#paper-3}

**Rank 3** · Score **81/100** (High) · cs.CR · PDF analyzed · [arXiv](https://arxiv.org/abs/2611.02788) · [PDF](https://arxiv.org/pdf/2611.02788) · [Annotated PDF](2611.02788-annotated.pdf)

The paper investigates neural decompilation by treating it as a two-stage problem: candidate generation followed by candidate selection. The authors demonstrate that correct code is frequently present in the model's top-k sampling space (top-5 in 95.6% of positions), but greedy decoding fails to retrieve it. They systematically evaluate various selection strategies, identifying negative perplexity as the strongest static selector and execution-guided selection as highly effective when test harnesses are available. Crucially, they release a new dataset, ExeBench-Obfuscated (362,647 samples), showing that fine-tuning on this data combined with multi-candidate selection allows off-the-shelf models to successfully decompile obfuscated binaries, contradicting prior claims of unsuitability.

**Reader takeaway:** Practitioners can improve decompilation results by implementing multi-candidate selection strategies (e.g., negative perplexity) rather than relying on greedy decoding of standard models.

**Why it stands out:** The paper provides a rigorous empirical analysis of the 'selection bottleneck' in LLM-based decompilation. It introduces a new large-scale obfuscated dataset (ExeBench-Obfuscated) and demonstrates that simple selection strategies combined with targeted fine-tuning can significantly improve performance on obfuscated inputs, challenging existing assumptions about model limitations.

**Key results** (numbers checked against the PDF):

- **HumanEval-Decompile, ExeBench**, Percentage of tokens at Rank=1, Top-5, Top-10; Mean Rank: Top-5: 95.6% (Avg); Rank=1: 84.5% (Avg); Mean Rank: 9.4 (Avg) (p. 7)
- **HumanEval-Decompile, ExeBench**, Pass@1 (%): Neg. Perplexity: 73.3% (C1), 55.0% (C2); Execution-Guided: 86.3% (C3), 75.4% (C4) (p. 9)
- **ExeBench-Obfuscated**, Pass@1, Compile Rate, Levenshtein, CodeBLEU: Fine-tuned + Execution-guided: 88.8% Pass@1, 94.7% Compile; Fine-tuned + Perplexity: 77.1% Pass@1 (p. 11)

*Metrics:* **pass@k** is the share of problems where at least one of the first k generated candidates passes the tests; **CodeBLEU** is the BLEU extended with syntax-tree and data-flow matching for code; **Levenshtein distance** is the number of single-character edits needed to turn the output into the reference; **Perplexity** is the how unlikely the model finds a text; lower means more likely.

**Paper's code:** [UzL-ITS/rethinking-neural-decompilation](https://github.com/UzL-ITS/rethinking-neural-decompilation)

**Related tools and projects** (cited by the paper, not its implementation): [jgamblin/Mirai-Source-Code](https://github.com/jgamblin/Mirai-Source-Code), [quarkslab/diffing&#95;obfuscation&#95;dataset](https://github.com/quarkslab/diffing_obfuscation_dataset)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** Correct reconstructions are typically already present in the model's sampling space; ground-truth tokens lie within the top-five next-token predictions in 95.6% of positions on average. (p. 1, 8)
- **Demonstrated:** Negative perplexity emerges as the strongest static selector on HumanEval-Decompile, achieving a pass@1 of 73.3%. (p. 2, 9)
- **Demonstrated:** Execution-guided selection nearly closes the oracle gap on ExeBench, reaching an pass@1 of 86.3%. (p. 2, 9)
- **Demonstrated:** Fine-tuning on the newly released ExeBench-Obfuscated dataset (362,647 samples) combined with selection increases pass@1 for obfuscated binaries to 88.8%. (p. 2, 11)
- **Limitation** (stated by the authors): Execution-guided selection relies on available unit tests/harnesses, which are rarely met in real-world reverse-engineering settings where static selectors are needed.
- **Limitation** (stated by the authors): The study focuses primarily on OLLVM-based obfuscation; while Tigress is mentioned as a complementary dataset, the core evaluation uses OLLVM transformations.
- **Method:** The study decomposes neural decompilation into token-level generation and program-level selection. It evaluates four configurations (Ghidra/Assembly inputs on HumanEval-Decompile and ExeBench). The authors measure token recoverability via rank analysis under teacher forcing, compare multiple selectors (perplexity, consensus, execution-guided) on a pool of 100 candidates, and assess robustness against OLLVM obfuscation techniques.
- **Relevance** (Agentic reverse engineering pipeline): The paper's core contribution is a 'generate-then-select' pipeline, which aligns directly with agentic reverse engineering workflows that require searching a space of candidates rather than relying on a single greedy output.
- **Relevance** (Binary triage and evidence-based analysis): The systematic comparison of selectors (perplexity, consensus, execution-guided) provides concrete techniques for triaging decompilation results to identify the most likely correct candidate.
- **Relevance** (Local model and agent architecture): The study uses existing LLM4Decompile checkpoints and demonstrates improvements via fine-tuning on a new dataset, relevant for optimizing local model deployments.

{{< /details >}}

### 4. VulDec: Vulnerability Detection in Binaries via Neural Decompilation {#paper-4}

**Rank 4** · Score **75/100** (High) · cs.CR · PDF analyzed · [arXiv](https://arxiv.org/abs/2610.33716) · [PDF](https://arxiv.org/pdf/2610.33716) · [Annotated PDF](2610.33716-annotated.pdf)

The paper introduces VulDec, an end-to-end framework for binary vulnerability detection using neural decompilation. The authors present a new dataset (VulDec) containing over 59,000 C-Assembly function pairs with CWE annotations across x86 and ARM architectures. They fine-tune LLMs to translate assembly to source code and then classify vulnerabilities. Experiments show that while decompiled code achieves reasonable structural fidelity (Edit Similarity &#126;56%), vulnerability detection remains challenging due to severe class imbalance (3% vulnerable rate). The best-performing model (PLBART) achieves a macro F1-score of 0.61 on an in-distribution test set and 0.57 on an out-of-distribution set. A key finding is that decompilation quality (Edit Similarity) does not strongly correlate with vulnerability detection performance, suggesting the detector relies on specific syntactic patterns rather than high-level semantics.

**Reader takeaway:** Vulnerability detection pipelines should not assume that better decompilation automatically leads to better detection; class imbalance handling and syntactic pattern recognition are critical.

**Why it stands out:** The paper demonstrates that neural decompilation can recover source-like code from binaries, but the recovered code is often structurally similar yet semantically insufficient for robust vulnerability detection. The study highlights a 'generalization gap' between in-distribution and out-of-distribution data, where performance drops significantly on real-world OOD test sets. It also shows that larger models do not necessarily outperform smaller ones for this task.

**Key results** (numbers checked against the PDF):

- **VulDec dataset (x86 and ARM subsets)**, Edit Similarity, BLEU-4, ROUGE-L: Qwen2.5-Coder: ES=55.83% (x86), 56.60% (ARM); BLEU-4=40.50% (x86), 43.42% (ARM). CodeT5+: BLEU-4=42.45% (x86), 44.41% (ARM). (p. 14)
- **VulDec in-distribution test set**, Vul-Precision, Vul-Recall, Vul-F1, Macro F1: PLBART: Vul-P=0.180, Vul-R=0.444, Vul-F1=0.257, Macro F1=0.606. Qwen2.5-Coder: Vul-P=0.180, Vul-R=0.301, Vul-F1=0.226, Macro F1=0.596. (p. 17)
- **OOD test set from PHP, openjpeg, poppler projects**, Edit Similarity, BLEU-4, Vul-F1, Macro F1: VD-Dec → VD-Det: ES=36.83, BLEU-4=19.36, Vul-F1=0.19, Macro F1=0.57. Ghidra → Flawfinder: Vul-F1=0.00. (p. 19)
- **VulDec dataset (x86)**, Precision, Recall, F1-Score per class: Safe class: P=0.89, R=1.00, F1=0.92. Vul class: P=0.00, R=0.00, F1=0.00. (p. 22)
- **VulDec test set**, Spearman’s rank correlation between Edit Similarity and Accuracy/F1-score: Accuracy correlates with ES; F1-score shows no statistically meaningful dependency on ES. Peak F1=61.5% near ES=0.3. (p. 20)

*Metrics:* **Macro F1** is the F1 averaged over classes with equal weight, so a rare class counts as much as a common one; **BLEU** is the n-gram overlap between generated and reference text; **ROUGE-L** is the overlap based on the longest common subsequence with the reference.

**Related tools and projects** (cited by the paper, not its implementation): [avast/retdec](https://github.com/avast/retdec), [keystone-engine/keystone](https://github.com/keystone-engine/keystone)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** VulDec introduces a new large-scale dataset of over 59,000 C-Assembly function pairs with CWE annotations across x86 and ARM architectures. (p. 10)
- **Demonstrated:** Fine-tuned LLM-based neural decompilers achieve strong source-level recovery with Edit Similarity of approximately 56% and BLEU-4 of approximately 43%. (p. 13)
- **Demonstrated:** Tuned LLM-based detectors reach a macro F1-score of 0.61 on an in-distribution realistic test set (3% vulnerability rate). (p. 16)
- **Demonstrated:** Decompilation quality (Edit Similarity) does not strongly correlate with vulnerability detection performance; F1-score shows no statistically meaningful dependency on Edit Similarity. (p. 20)
- **Limitation** (stated by the authors): The study relies on Debian packages for binary compilation, limiting generalizability to non-Debian distributions or proprietary binaries.
- **Limitation** (stated by the authors): Severe class imbalance (3% vulnerable rate) persists even after mitigation strategies, leading to modest vulnerability-specific F1-scores.
- **Limitation** (stated by the authors): Decompiled code lacks precise type information and whole-program context, which may limit the effectiveness of source-level analysis tools.
- **Method:** The authors construct the VulDec dataset by extracting vulnerable and non-vulnerable C functions from real-world open-source projects (via DiverseVul), compiling them to binaries using Debian packages, disassembling them, and aligning assembly symbols with source function names. They then fine-tune various LLM architectures (decoder-only, encoder-only, encoder-decoder) for two tasks: (1) neural decompilation (assembly-to-source translation) and (2) vulnerability detection (binary classification). For detection, they evaluate strategies to handle severe class imbalance (3% vulnerable rate), finding that a hybrid of under-sampling (80-20) and class weighting works best for most models. They also test an assembly-only baseline and compare against traditional rule-based pipelines (Ghidra + Flawfinder).
- **Relevance** (Binary triage and evidence-based analysis): VulDec provides a dataset and framework for binary-level vulnerability triage using neural decompilation, directly applicable to projects focused on evidence-based analysis of binaries.
- **Relevance** (Local model and agent architecture): The study evaluates small-to-medium models (e.g., CodeT5+ 220M, Qwen2.5-Coder 3B) and finds they can be competitive with larger models, supporting local model deployment for binary analysis.
- **Relevance** (Embedded and hardware security): The dataset includes ARM architecture binaries, making VulDec relevant for embedded/IoT security research.

{{< /details >}}

### 5. Locate, Then Reason: End-to-End Patch Presence Testing in Stripped Binaries {#paper-5}

**Rank 5** · Score **75/100** (High) · cs.CR · PDF analyzed · [arXiv](https://arxiv.org/abs/2610.25071) · [PDF](https://arxiv.org/pdf/2610.25071) · [Annotated PDF](2610.25071-annotated.pdf)

The paper presents PatchAlign, an end-to-end workflow for Binary Patch Presence Testing (PPT) in stripped binaries. It addresses limitations of prior systems that assume known function locations or rely on brittle function-level similarity. PatchAlign combines instruction-aligned retrieval (using InsnAlign), CFG-guided windowing to handle inlining and context limits, caller-callee context refinement, and LLM-based relevance screening and reasoning. Experiments on a balanced PS3 benchmark show high accuracy (96.77% with decompiled code) and low false positives compared to baselines.

**Reader takeaway:** PatchAlign offers a high-accuracy method for binary patch presence testing without requiring function addresses or symbols, reducing false positives significantly.

**Why it stands out:** The paper demonstrates that instruction-aligned retrieval with CFG windows can overcome context truncation and inlining issues, while caller-callee context refinement improves recall. LLM-based screening achieves high reliability on distinguishing exact matches from incidental similarity. The end-to-end design avoids the 'missing function' problem of prior systems.

**Key results** (numbers checked against the PDF):

- **PS3-Balanced (reconstructed from PS3; 62 CVEs across FFmpeg, OpenSSL, tcpdump, libxml2)**, Accuracy, Precision, Recall, F1, MISSING count: PatchAlign (decompile): Acc=100.00% (gcc-O3→gcc-O3), 98.39% (gcc-O3→clang-O3), 100.00% (gcc-Os→gcc-Os), 97.58% (gcc-Os→clang-Os); Overall Acc=97.18%, F1=97.15%. Baselines: PS3+inline Acc≈69–78%, React (p. 14)
- **PS3-Balanced; 768 localization queries across four target settings**, Recall@1/5/10, MRR: Context-aware refinement: Recall@1=87.11%, @5=97.27%, @10=97.53%; MRR=0.9146; significant improvement over MAS (Recall@10=90.23%, MRR=0.8616) (p. 15). (p. 15)
- **PS3-Balanced; queries with correct top-10 candidate**, Correct/total (percentage) for Exact, Contained, Overall, Irrelevant: Decompiled C: Overall=743/768 (96.74%), Irrelevant=190/190 (100.00%); Assembly: Overall=737/768 (95.96%), Irrelevant=217/224 (96.88%) (p. 16). (p. 16)
- **62 CVEs, 496 targets; AMD 9950X3D2 + RTX 5090**, Wall time (h/s), LLM calls, input/output tokens: Offline: &#126;2 hours total for plan generation. Online: Windowing+Retrieval mean=1,121s; Context-Aware Refinement mean=38s; Relevance Screening (assembly) mean=663s (p. 17). (p. 17)

*Metrics:* **F1** is the harmonic mean of precision and recall (1.0 is perfect).

**Related tools and projects** (cited by the paper, not its implementation): [openssl/openssl](https://github.com/openssl/openssl), [the-tcpdump-group/tcpdump](https://github.com/the-tcpdump-group/tcpdump)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** PatchAlign performs end-to-end PPT without requiring a target function or address oracle, combining recall-oriented localization with patch-conditioned reasoning. (p. 1, 2)
- **Demonstrated:** Instruction-aligned retrieval with CFG-guided windowing enables high-recall localization even when functions are inlined or exceed encoder context limits. (p. 15)
- **Demonstrated:** LLM-based relevance screening reliably distinguishes exact/contained matches from irrelevant code, with decompiled C achieving 99.20% accuracy on irrelevant rejection. (p. 16)
- **Demonstrated:** PatchAlign achieves 96.77% accuracy and 97.15% F1 with decompiled code, significantly outperforming baselines like PS3+inline (70.59% Acc) and React (symbols) (75.81% Acc). (p. 14)
- **Limitation** (stated by the authors): The evaluation uses a rebuilt PS3 benchmark; real-world distributions may differ.
- **Limitation** (stated by the authors): Relevance screening relies on an LLM; while accuracy is high, cost and latency depend on model choice and context limits.
- **Limitation** (stated by the authors): The system assumes paired reference functions for reasoning; one-sided functions are handled but may lack detailed plans.
- **Method:** PatchAlign performs four stages: (1) Reference Patch Analysis extracts patch-relevant functions and generates an analysis plan; (2) Semantic Localization uses instruction-aligned embeddings and CFG windows for high-recall retrieval; (3) Relevance Screening uses an LLM to classify candidates as exact/contained/wrong; (4) Patch-Status Reasoning uses the cached plan and LLM to decide vulnerable/patched/uncertain. The system works without symbols or location oracles.
- **Relevance** (Binary triage and evidence-based analysis): PatchAlign provides a symbol-free, end-to-end PPT workflow suitable for triaging stripped binaries in vulnerability assessment pipelines.
- **Relevance** (Local model and agent architecture): The system uses local inference (deepseek-v4-flash-0731) with offline plan reuse, aligning with local model deployment goals.
- **Relevance** (Embedded and hardware security): By handling inlining and stripped binaries, PatchAlign supports embedded/firmware analysis where symbols are often unavailable.

{{< /details >}}

### 6. SEMPRE: Semantic-Aware Protocol Reverse Engineering via Consistency-Driven Joint Optimization {#paper-6}

**Rank 6** · Score **79/100** (High) · cs.CR · PDF analyzed · [arXiv](https://arxiv.org/abs/2610.31844) · [PDF](https://arxiv.org/pdf/2610.31844) · [Annotated PDF](2610.31844-annotated.pdf)

SEMPRE is a fully automated Protocol Reverse Engineering (PRE) framework that integrates fine-grained dynamic program analysis with recursive LLM reasoning to jointly optimize field detection and semantic inference. It addresses limitations in existing tools by handling nested protocols, modeling contextual dependencies between fields, and avoiding brittle hand-crafted heuristics. The system uses taint-flow and loop traces to guide a Tree-of-Thoughts (ToT) search for segmentation, then iteratively refines boundaries using high-confidence semantic constraints until convergence.

**Reader takeaway:** SEMPRE demonstrates that combining dynamic taint analysis with LLM reasoning helps with nested protocols and undocumented security mechanisms.

**Why it stands out:** SEMPRE demonstrates that combining dynamic analysis with LLM reasoning can significantly outperform heuristic-based PRE tools. It achieves an average F1 of 0.76 for field detection and 0.72 for semantic inference, substantially surpassing the best baseline (BinPRE) which scores 0.39 and 0.14 respectively. The framework effectively handles nested protocols like EtherNet/IP encapsulating CIP payloads and robustly analyzes undocumented malware protocols such as Mirai.

**Key results** (numbers checked against the PDF):

- **D1 (8 protocols: Modbus, S7comm, Ethernet/IP, DNP3, DNS, FTP, TFTP, HTTP) + D2 (undocumented KTP, CCN, Xfer)**, Average F1 Score: &#123;"SEMPRE": 0.76, "BinPRE": 0.39, "Polyglot": 0.33, "AutoFormat": 0.49, "Tupni": 0.58, "BinaryInferno": 0.28, "DynPRE": 0.63&#125; (p. 10, 11)
- **D1 dataset (Type and Function inference)**, Average F1 Score: &#123;"SEMPRE": 0.72, "BinPRE": 0.14&#125; (p. 10)
- **D1 dataset (Zero-prior-knowledge setting)**, Average F1 Score: &#123;"SEMPRE-zero": 0.72, "BinPRE": 0.35&#125; (p. 11)
- **Small-scale dataset (first 10 messages per protocol)**, Average F1 Score (Field Detection): &#123;"SEMPRE-norec-noop": 0.58, "SEMPRE": 0.76&#125; (p. 11)
- **Mirai malware protocol (10 messages)**, Field Detection F1 Score: &#123;"SEMPRE": 0.83, "BinPRE": 0.55&#125; (p. 12)

**Paper's code:** the authors say code is available, but no repository link could be verified.

**Related tools and projects** (cited by the paper, not its implementation): [laksh0820/Custom-Transport-Protocol-Socket](https://github.com/laksh0820/Custom-Transport-Protocol-Socket), [BenjaminWang236/Custom-Protocol-for-Client-Server-Communication](https://github.com/BenjaminWang236/Custom-Protocol-for-Client-Server-Communication), [ZAK3IR/xfer](https://github.com/ZAK3IR/xfer), [jgamblin/Mirai-Source-Code](https://github.com/jgamblin/Mirai-Source-Code), [cwalter-at/freemodbus](https://github.com/cwalter-at/freemodbus)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** SEMPRE achieves an average F1 score of 0.76 for field detection, significantly outperforming all six state-of-the-art PRE baselines which average below 0.40. (p. 9)
- **Demonstrated:** SEMPRE achieves an average F1 score of 0.72 for semantic inference, substantially outperforming the state-of-the-art BinPRE which scores 0.14. (p. 10)
- **Demonstrated:** SEMPRE effectively handles nested protocols by recursively applying field detection to sub-payloads, improving F1 scores for protocols like Ethernet/IP and HTTP. (p. 11)
- **Demonstrated:** SEMPRE maintains strong performance without prior LLM knowledge or with a different backbone LLM, consistently outperforming SOTA techniques. (p. 11)
- **Claimed, not demonstrated:** The iterative joint optimization process converges to a stable fixed point under the assumption that high-confidence LLM predictions are reliable constraints.
- **Limitation** (stated by the authors): SEMPRE's performance on DNP3 is reduced when prior knowledge is removed due to API input-length constraints forcing truncation of taint context.
- **Limitation** (stated by the authors): The convergence analysis relies on practical behavioral assumptions about LLM reliability rather than a formal guarantee of global optimality.
- **Method:** SEMPRE performs byte-level dynamic taint analysis and loop detection on protocol binaries to extract execution evidence. It employs an LLM-driven Tree-of-Thoughts search to propose candidate segmentations consistent with this evidence. The system recursively detects nested sub-payloads and alternates between field detection and semantic inference, freezing high-confidence predictions to refine ambiguous regions in subsequent iterations.
- **Relevance** (Agentic reverse engineering pipeline): SEMPRE directly implements an agentic reverse engineering pipeline using LLM-driven Tree-of-Thoughts search and iterative refinement, fitting the 'agentic&#95;re' project scope.
- **Relevance** (Binary triage and evidence-based analysis): The framework's use of dynamic taint analysis and loop detection for binary-based protocol understanding aligns with 'binary&#95;triage' goals.
- **Relevance** (Local model and agent architecture): Evaluation includes testing with DeepSeek-v3.1-terminus, suggesting compatibility with local or alternative model architectures beyond just GPT-o3.

{{< /details >}}

### 7. JANUS: Agentic Cross-Language Fuzzing Harness Generation for Android Native Libraries {#paper-7}

**Rank 7** · Score **80/100** (High) · cs.SE · PDF analyzed · [arXiv](https://arxiv.org/abs/2610.30218) · [PDF](https://arxiv.org/pdf/2610.30218) · [Annotated PDF](2610.30218-annotated.pdf)

The paper introduces Janus, an agentic framework for generating cross-language JNI-aware fuzzing harnesses for Android native libraries. It addresses challenges in recovering app-specific runtime context and constructing complex composite objects by using LLM agents with structure-aware retrieval, dependency-driven call sequence extraction, recursive argument construction, and a feedback-driven refinement loop. Evaluated on 44 real-world apps (Poirot-44) and 20 vendor-preinstalled apps (Vendor-20), Janus generates significantly more valid harnesses than state-of-the-art tools (Atlas++, Poirot) and uncovers previously unknown vulnerabilities in closed-source native libraries.

**Reader takeaway:** Janus enables the generation of valid cross-language fuzzing harnesses for Android native libraries, and found 6 previously unknown vulnerabilities in closed-source native libraries from Android vendors.

**Why it stands out:** Structure-aware cross-language code retrieval bridging Java and C/C++ symbol spaces; dependency-driven iterative resolution of explicit/implicit JNI call sequences; recursive bottom-up construction of composite Java objects via reflection-style JNI APIs; harness memory for reusing verified components across methods.

**Key results** (numbers checked against the PDF):

- **Poirot-44**, #Build, #Run, Coverage (#Cov), #Crashes: Janus: 6,094 valid harnesses (84.0% of generated); Atlas++: 13 apps with 404 crashes; Poirot: 14 apps with 905 crashes. Janus coverage significantly higher than baselines. (p. 16, 17)
- **Vendor-20**, #Build, #Run, Coverage, #Crashes (unknown vulnerabilities): Janus uncovers 6 previously unknown memory-corruption vulnerabilities in closed-source native libraries. (p. 19)
- **Poirot-44**, Degradation (%) relative to full Janus in #Run and Coverage: Fig. 5 shows degradation percentages for each ablation variant (exact numbers truncated in text but qualitative impact confirmed). (p. 18)

**Paper's code:** [Project-Z5O1/Janus](https://github.com/Project-Z5O1/Janus)

**Related tools and projects** (cited by the paper, not its implementation): [anomalyco/opencode](https://github.com/anomalyco/opencode), [AtlasPlusPlus/Atlas-plusplus](https://github.com/AtlasPlusPlus/Atlas-plusplus), [eclipse-jdtls/eclipse.jdt.ls](https://github.com/eclipse-jdtls/eclipse.jdt.ls), [skylot/jadx](https://github.com/skylot/jadx)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Claimed, not demonstrated:** Janus is the first agentic approach to synthesizing cross-language JNI-aware fuzzing harnesses for Android native libraries, resolving both explicit and implicit call dependencies and recursively assembling composite argument objects.
- **Claimed, not demonstrated:** On the Poirot-44 dataset (44 apps, 21,386 JNI methods), Janus produces over 5.9× more valid harnesses than state-of-the-art tools, with 6,094 valid harnesses out of 7,257 generated.
- **Claimed, not demonstrated:** Janus achieves 5.8× and 6.5× higher bitmap coverage compared to Atlas++ and Poirot, respectively, on the Poirot-44 dataset.
- **Limitation** (stated by the authors): The evaluation relies on decompiled APKs and native libraries; closed-source nature of native libraries limits transferability of JNI usage patterns.
- **Limitation** (reviewer's observation): Ablation study results are presented qualitatively in Fig. 5 with truncated numeric details in the provided text; exact degradation percentages not fully reported.
- **Limitation** (reviewer's observation): The paper uses GLM-5 as the primary model; generalization to other LLMs or open-weight models is not evaluated.
- **Method:** Janus employs a three-phase agentic workflow: (1) Cross-Language Parser to unify Java-native interaction views; (2) Harness Synthesizer using structure-aware retrieval, dependency-driven call sequence extraction, recursive argument construction, and harness memory management; (3) Feedback-driven Harness Refiner that uses templates and coverage-guided validation. The system is implemented as OpenCode Skills guiding an LLM agent (GLM-5).
- **Relevance** (Agentic reverse engineering pipeline): Janus is an agentic reverse engineering pipeline specifically for JNI-aware harness generation, directly aligning with the agentic&#95;re project.
- **Relevance** (Binary triage and evidence-based analysis): Janus's cross-language parser and dependency resolution support binary triage of native libraries by reconstructing valid invocation contexts.
- **Relevance** (Local model and agent architecture): The paper uses GLM-5 (a local/open-weight model) for cost-effective inference, relevant to local&#95;models project.

{{< /details >}}

### 8. Scythe: Semantic-Aware Rewriting for Fast,Effective Program Reduction {#paper-8}

**Rank 8** · Score **81/100** (High) · cs.SE · PDF analyzed · [arXiv](https://arxiv.org/abs/2611.06515) · [PDF](https://arxiv.org/pdf/2611.06515) · [Annotated PDF](2611.06515-annotated.pdf)

Scythe is a semantic-aware pre-processing tool for automated program reduction that runs in front of language-agnostic grammar-based reducers (like PERSES and LATRA) without modifying them. It constructs a typed declaration dependency graph to decouple declarations from their use sites using semantic operators, enabling the removal of whole classes, methods, and fields while preserving well-typedness. Evaluated on 73 benchmarks across C, Java, and Solidity, Scythe combined with PERSES never yields a larger result than PERSES alone, producing strictly smaller programs in 70/73 cases (average reduction: 55.6%, up to 95.5%) and speeding up reduction by 2.3× on average (up to 7.4×). When paired with LATRA, it yields programs 10.6% smaller on average and is 2.4× faster.

**Reader takeaway:** Scythe can be integrated into existing reduction pipelines to remove irrelevant code and speed up fuzzing campaigns without modifying the underlying reducer logic.

**Why it stands out:** Scythe bridges the gap between language-specific and language-agnostic reducers by enabling bulk removal of irrelevant code blocks that syntax-guided search alone cannot handle. It introduces a typed dependency graph abstraction and semantic rewrite operators (e.g., replacing calls with default values, rewriting inheritance edges) that are generalizable across languages.

**Key results** (numbers checked against the PDF):

- **73 benchmarks: C (20), Java (34), Solidity (19)**, Program size (tokens) and reduction time (seconds): S+P never larger than P; strictly smaller on 70/73 cases; average size reduction 55.6% (up to 95.5%); speedup 2.3× (up to 7.4×). For LATRA: 10.6% smaller (up to 61.8%), 2.4× faster on average. (p. 1)
- **clang-31259, gcc-64990, gcc-61917, gcc-59903 (C); jdk11-10, jdk11-7, jdk8-24, jdk8-34 (Java); smart17, smart7, smart13, smart4 (Solidity)**, Tokens and seconds for S, P, S+P: C: avg size reduction 71.7%, speedup 1.6×; Java: 59.5% reduction, 3.0× speedup; Solidity: 31.6% reduction, 1.6× speedup. LATRA: 2.4× faster on average. (p. 3)

**Paper's code:** [itiarom/scythe](https://github.com/itiarom/scythe)

**Related tools and projects** (cited by the paper, not its implementation): [hephaestus-compiler-project/hephaestus](https://github.com/hephaestus-compiler-project/hephaestus)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** Scythe is a fast, semantic-aware pre-processing step that runs in front of any grammar-based reducer without modifying it. (p. 1, 3)
- **Demonstrated:** Scythe encodes the program as a typed declaration dependency graph and performs semantic-aware operators that decouple declarations from their use sites. (p. 2, 3)
- **Demonstrated:** Combining Scythe with PERSES never yields a larger result than PERSES alone on 73 benchmarks, and produces strictly smaller programs in 70 of 73 cases. (p. 1, 3)
- **Demonstrated:** On average, the combination produces programs 55.6% smaller (up to 95.5%) and is 2.3× faster (up to 7.4×) compared to PERSES alone. (p. 1)
- **Limitation** (stated by the authors): In six cases, the output grows by 3–86 tokens when paired with LATRA due to default values (e.g., 0xDEADBEEF) hindering LATRA's transformations.
- **Limitation** (stated by the authors): The evaluation is described as 'preliminary' with plans to select operators and default values context-sensitively in future work.
- **Method:** The authors implement Scythe in Python (&#126;4,000 lines) using tree-sitter for parsing and picire for delta debugging. It iterates four steps: (1) dependency graph construction, (2) delta debugging over declarations, (3) program rewrite via semantic decoupling operators, and (4) property checking. The tool is open-source under GPL-3.0.
- **Relevance** (Binary triage and evidence-based analysis): Scythe's semantic decoupling operators and dependency graph can be used to triage and reduce binaries or test cases in compiler testing pipelines.
- **Relevance** (capa/FLOSS integration): The typed dependency graph could inform feature extraction or capability analysis by identifying relevant code blocks.
- **Relevance** (Local model and agent architecture): Scythe's lightweight Python implementation and modular design make it suitable for local inference setups in security tooling.

{{< /details >}}

### 9. PhotoFinish: Portable Timerless Probing of Microarchitectural Latencies {#paper-9}

**Rank 9** · Score **91/100** (Critical) · cs.CR · PDF analyzed · [arXiv](https://arxiv.org/abs/2611.09879) · [PDF](https://arxiv.org/pdf/2611.09879) · [Annotated PDF](2611.09879-annotated.pdf)

PhotoFinish is a portable, timerless microarchitectural probing primitive that converts latency differences into architectural values via shared-memory races between two threads. It works across x86&#95;64, AArch64, RISC-V, and LoongArch, including inside browsers (WebAssembly) and on restricted hardware like Apple M1. The authors demonstrate reliable cache-state classification (L1 vs DRAM, LLC vs DRAM), detection of TLB residency and AVX wakeup throttling, and recovery of an address’s LLC slice with 96.9% accuracy using aggregated measurements.

**Reader takeaway:** PhotoFinish provides a portable, timerless method for microarchitectural probing that works on restricted hardware and inside browsers, expanding the attack surface for side-channel analysis.

**Why it stands out:** PhotoFinish provides a generic, calibration-free (unpadded) or calibrated (padded) way to observe microarchitectural latencies without timers or ISA-specific features. It enables timerless Flush+Reload-style attacks, Evict+Reload covert channels on Apple M1, and detection of non-cache latencies (TLB, AVX throttling). The primitive is implemented in native assembly, WebAssembly, and Lua.

**Key results** (numbers checked against the PDF):

- **38 physical CPUs (45 native platform configurations after separating hybrid cores)**, Δsync (midpoint of uncertain range U in add-cycles); transition width &#124;U&#124;: Δsync varies by platform and core placement; on AMD EPYC 7252, Δsync = 78 add-cycles within a CCX vs. 563 add-cycles across CCXs (p. 7). (p. 7)
- **45 native platform configurations; cross-core and SMT sibling placements**, F1 score (fast state as positive class); golden range width for padded variant: Unpadded: 41 of 45 platforms achieve F1 ≥ 0.97 for L1 vs DRAM; 37 of 45 exceed F1 = 0.99 for LLC vs DRAM (p. 8). (p. 8)
- **45 native platforms; cross-core and SMT sibling placements**, Edge width of counter updates vs. Δsync; F1 scores for L1 vs DRAM and LLC vs DRAM: Cross-core edge width &gt; Δsync on 28 of 45 platforms; counting threads exceed F1 = 0.97 on 36 of 40 platforms for L1 vs DRAM, unpadded PhotoFinish on 37 (p. 9). (p. 8)
- **x86&#95;64; 50 matched configurations**, Pearson correlation between WebAssembly and native results; F1 scores for L1 vs DRAM: Pearson r = 0.930; unpadded WebAssembly achieves F1 ≥ 0.99 in 46 of 50 configurations (p. 9). (p. 9)
- **41 platforms (excluding Apple M1/M2 due to 128 B cache lines)**, Success rate; median runtime: 37 of 41 platforms achieve 100% success rate; median runtime = 315 ms (p. 10). (p. 10)

**Paper's code:** the authors say code is available, but no repository link could be verified.

**Related tools and projects** (cited by the paper, not its implementation): [sifive/block-inclusivecache-sifive](https://github.com/sifive/block-inclusivecache-sifive)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** PhotoFinish converts microarchitectural latency differences directly into an architectural value via a shared-memory race between two threads, without reading or constructing a timer. (p. 1)
- **Demonstrated:** Unpadded PhotoFinish reliably separates L1 hits from DRAM accesses on most platforms, and padded PhotoFinish achieves this on all tested platforms. (p. 8)
- **Demonstrated:** PhotoFinish can replace timed probing in practical attacks, including an AES T-table attack and a timerless Evict+Reload-style covert channel on Apple M1. (p. 10)
- **Demonstrated:** PhotoFinish can determine an address’s LLC slice with 96.9% accuracy using aggregated measurements on a 12-slice Intel CPU. (p. 1)
- **Limitation** (stated by the authors): Unpadded PhotoFinish fails on platforms where the L1-to-DRAM separation is too small relative to Δsync (Core i5-6400T, Ampere Altra Q64-30).
- **Limitation** (stated by the authors): On some platforms (Huawei Kunpeng 920, Core Ultra 5 325 efficiency cores), DRAM latency variability causes some nominally slow probes to complete before the reference path.
- **Limitation** (stated by the authors): SMT sibling placement widens the uncertain range and reduces single-shot temporal precision compared to separate physical cores.
- **Method:** PhotoFinish races a probing thread T0 executing the target operation against a reference thread T1 executing a fixed reference operation. Both threads write distinct marker values to a shared result word w; cache coherence serializes these writes, and the final value reveals which path completed later. An unpadded variant works when the latency difference exceeds the synchronization latency Δsync; a padded variant adds a calibrated delay Δpad to T0 to shift the race boundary for smaller differences. The authors control jitter via cache/coherence state preparation, instruction-ordering dependencies, and thread pinning.
- **Relevance** (Agentic reverse engineering pipeline): PhotoFinish provides a timerless, portable primitive for microarchitectural probing that can be integrated into agentic reverse engineering pipelines to perform cache-based side-channel analysis without relying on high-resolution timers or privileged instructions.
- **Relevance** (Binary triage and evidence-based analysis): The primitive enables evidence-based analysis of microarchitectural state (cache, TLB, execution engine) in restricted environments, supporting triage workflows that must operate under timer restrictions.
- **Relevance** (Local model and agent architecture): PhotoFinish works in browsers and on constrained hardware, making it suitable for local inference scenarios where precise timers are unavailable or coarsened.

{{< /details >}}

### 10. APG: Agentic Static-Analysis Infrastructure on LLVM-IR Graph Databases {#paper-10}

**Rank 10** · Score **79/100** (High) · cs.SE · PDF analyzed · [arXiv](https://arxiv.org/abs/2611.02349) · [PDF](https://arxiv.org/pdf/2611.02349) · [Annotated PDF](2611.02349-annotated.pdf)

APG is an infrastructure that exposes LLVM-IR static analyses as agent-invocable capabilities via a graph database (TuGraph). It decomposes SVF-derived analyses into 38 atomic capabilities, uses semantics-aware interfaces and query safeguards to guide LLM agents in goal-directed investigation, and maintains inspectable evidence traces. Evaluated on 812 C/C++ defects, APG achieves high first-attempt query success (35/38 &gt;50%, 13 at 100%), reduces invalid query rate to 0.8%, and improves repair success@1 by 17.6–18.0 pp over Passive Graph Push while cutting LLM input tokens by 90.8%.

**Reader takeaway:** APG exposes LLVM-IR static analyses as agent-invocable capabilities, reducing LLM token consumption by over 90% while improving repair success rates in goal-directed investigation.

**Why it stands out:** APG demonstrates that exposing static-analysis operations as atomic, semantics-grounded capabilities enables LLM agents to perform reliable, goal-directed program investigations without relying on passive graph-context injection. The combination of a Graph Semantics Catalog, query guards, and provenance-aware evidence organization yields high first-attempt query success and low invalid-query rates in practice.

**Key results** (numbers checked against the PDF):

- **Internal benchmark derived from SVF analyses on C/C++ programs; specific defect sets used for repair evaluation.**, Query S@1 (first-attempt success rate per capability): 35/38 &gt;50%; 13 at 100% (Table I) (p. 3). (p. 3)
- **Same SVF-based analysis workload; defect sets not specified for this ablation.**, Invalid Query Rate (IQR) and Repair S@1: Full pipeline: IQR=0.8%, Repair S@1=32.8%; Without catalog: IQR=68.4%, S@1=4.8%; Without guards/replanning: IQR=14.2%, S@1=21.5% (Table II) (p. 3). (p. 3)
- **812 C/C++ defects: 277 from Multi-SWE-bench, 535 from Defects4C/ManyBugs (p. 3).**, Repair Success@1 and @5; LLM input tokens per defect: APG S@1=32.8% (Multi-SWE), S@5=45.4%; APG S@1=29.2% (D4C/ManyBugs), S@5=41.6%. Tokens: 45.8K (Passive Push) → 4.2K (APG), 90.8% reduction (Table III) (p. 3). (p. 3)

**Paper's code:** [JasonZhongZexin/APG-ICSE-Demo](https://github.com/JasonZhongZexin/APG-ICSE-Demo)

{{< details title="Claims, limitations, method and relevance" closed="true" >}}

- **Demonstrated:** APG decomposes compiler-derived static analyses into 38 atomic, agent-invocable capabilities that LLM agents can select and orchestrate for goal-directed investigation. (p. 1, 3)
- **Demonstrated:** Query safeguards (Query Guard, Schema Guard, goal/query alignment) reduce invalid query rate to 0.8% and improve repair success@1 over baselines. (p. 3)
- **Demonstrated:** APG improves first-iteration repair success by 17.6 pp on Multi-SWE-bench and 18.0 pp on Defects4C/ManyBugs compared to Passive Graph Push. (p. 3)
- **Demonstrated:** APG reduces average LLM input-token consumption by 90.8% compared to Passive Graph Push (45.8K → 4.2K tokens per defect). (p. 1, 3)
- **Limitation** (stated by the authors): The authors note that first-attempt success rates characterize the benchmark workload and do not guarantee the same outcomes for unseen requests.
- **Limitation** (stated by the authors): Zero-hit results may reflect absent relationships, incomplete graph information, or query-goal mismatch; they do not establish absence of a property without further investigation.
- **Limitation** (stated by the authors): Evaluation is limited to C/C++ defects and uses GPT-4o with temperature 0.0; generalization to other languages, models, or deployment settings is not assessed.
- **Method:** The authors build APG on SVF and LLVM, materializing five interprocedural analysis graphs (PAG, ICFG, Call Graph, SVFBasicBlock Graph, CHG) in TuGraph. They expose atomic capabilities through a semantics-aware interface that separates intent, semantic capability, and query realization. Query generation is guarded by syntax/safety checks (Query Guard), schema validation (Schema Guard), and goal/query alignment assessment. An iterative controller coordinates bounded investigation steps, consolidating local/global evidence summaries while preserving analysis traces for inspection.
- **Relevance** (Agentic reverse engineering pipeline): APG directly enables agentic reverse engineering by exposing static-analysis operations as atomic capabilities that agents can select and orchestrate for goal-directed investigation.
- **Relevance** (Binary triage and evidence-based analysis): The semantics-grounded capabilities and inspectable evidence traces support fault localization, root-cause diagnosis, and structured program slicing.
- **Relevance** (capa/FLOSS integration): APG’s decomposition of analyses into atomic capabilities aligns with capa/FLOSS-style capability modeling for static analysis queries.

{{< /details >}}

## Cross-paper synthesis

This section compares the papers above. Each part says what kind of statement it makes: a **finding** was demonstrated in a source paper, an **interpretation** comes from comparing papers, and a **proposal** is an untested idea. The links point to the paper sections each statement is based on.

### How the papers relate

*Interpretation: drawn by comparing the linked papers, not a result of any single paper.*

- **ATLAS and APG both leverage LLVM-IR for analysis but differ in orchestration**: APG decomposes SVF-derived analyses into atomic capabilities exposed via a graph database to guide LLM agents, whereas ATLAS focuses on lifting binaries to canonical IR using an iterative repair loop with ADVISOR/VALIDATOR agents. ([#2](#paper-2), [#10](#paper-10))
- **Decompilation quality vs. Vulnerability detection utility**: Rethinking Neural Decompilation measures success by how faithful the decompiled code is; VulDec finds that one fidelity measure, Edit Similarity, does not strongly predict vulnerability-detection performance, so fidelity gains may not carry over to detection. ([#4](#paper-4), [#3](#paper-3))
- **Agent-based fuzzing harness generation**: Janus uses agentic workflows to generate cross-language fuzzing harnesses for Android, while CyberBinGym evaluates agents on vulnerability recovery; Janus focuses on harness validity and coverage, whereas CyberBinGym highlights the difficulty of exploitation despite successful recovery. ([#7](#paper-7), [#1](#paper-1))
- **Semantic awareness in analysis**: SEMPRE and Scythe both utilize semantic awareness to improve analysis—SEMPRE for protocol segmentation via joint optimization, and Scythe for program reduction by decoupling declarations from use sites. ([#6](#paper-6), [#8](#paper-8))

### Shared methods

*Interpretation: drawn by comparing the linked papers, not a result of any single paper.*

- **LLM-driven iterative refinement loops**: ATLAS uses an ADVISOR/VALIDATOR loop for IR repair; Janus uses a feedback-driven harness refiner; SEMPRE uses recursive LLM reasoning to refine boundaries. All rely on iterative correction guided by diagnostics or validation. ([#2](#paper-2), [#7](#paper-7), [#6](#paper-6))
- **Structure-aware retrieval for context alignment**: ATLAS uses pseudo-probe attribution to align assembly regions with IR exemplars; Janus uses structure-aware retrieval for dependency-driven call sequence extraction; PatchAlign uses instruction-aligned embeddings. ([#2](#paper-2), [#7](#paper-7), [#5](#paper-5))

### Emerging trends

*Interpretation: drawn by comparing the linked papers, not a result of any single paper.*

- **Shift from monolithic LLM generation to agentic orchestration with validation loops**: ATLAS, Janus, SEMPRE and APG each wrap the model in explicit validation and refinement steps and report gains over single-pass or rule-based baselines, which suggests this structure helps on complex tasks such as lifting and harness generation. ([#2](#paper-2), [#7](#paper-7), [#6](#paper-6), [#10](#paper-10))
- **Integration of static and dynamic evidence for robustness**: SEMPRE combines taint-flow with LLM reasoning; APG maintains inspectable evidence traces; CyberBinGym validates via differential crash testing. Each pairs model reasoning with independent evidence instead of relying on model output alone. ([#6](#paper-6), [#10](#paper-10), [#1](#paper-1))
- **Evaluation across several instruction-set architectures**: ATLAS (x86-64, ARM64, RISC-V), PhotoFinish (38 CPUs spanning x86-64, AArch64, RISC-V and LoongArch) and VulDec (x86 and ARM) each evaluate on more than one instruction-set architecture. ([#2](#paper-2), [#9](#paper-9), [#4](#paper-4))

### Open questions

*Open question: left unanswered by the linked papers.*

- **Generalization of agentic frameworks to proprietary binaries and non-standard ISAs**: ATLAS limits evaluation to x86-64, ARM64, and RISC-V; Janus relies on decompiled APKs limiting transferability. There is a need for tools that handle closed-source or proprietary binaries without source access. ([#2](#paper-2), [#7](#paper-7))
- **Robustness of AI agents against production hardening and runtime environments**: CyberBinGym notes that standard hardening reduces but does not eliminate exploitation, yet it does not measure production compromise rates or time to exploit newly released patches in deployed systems. ([#1](#paper-1))
- **Handling severe class imbalance in vulnerability detection without synthetic data bias**: VulDec struggles with a 3% vulnerable rate; while mitigation strategies help, the gap between decompilation quality and detection performance remains open for real-world binaries. ([#4](#paper-4))
- **Cost and latency of LLM-based relevance screening in resource-constrained environments**: PatchAlign relies on an LLM for relevance screening; while accurate, the cost and latency depend on model choice, which is a limitation for large-scale or low-latency applications. ([#5](#paper-5))

### Experiments worth trying

*Proposal: hypotheses to test, not results.*

1. **Evaluate the impact of candidate selection strategies on decompilation success** (medium effort): Determine if negative perplexity or execution-guided selection improves pass@1 rates for obfuscated binaries compared to greedy decoding. ([#3](#paper-3))
   - Fine-tune a base model (e.g., Qwen2.5-Coder) on the ExeBench-Obfuscated dataset released in 2611.02788.
   - Implement a selection module that ranks top-k candidates using negative perplexity scores and executes them against available harnesses.
   - Compare pass@1 metrics against greedy decoding baselines on a subset of HumanEval-Decompile tasks.
2. **Integrate PhotoFinish into existing side-channel analysis toolchains** (high effort): Verify that timerless probing primitives work reliably on restricted hardware (e.g., Apple M1) and inside browsers. ([#9](#paper-9))
   - Port the PhotoFinish assembly implementation to a Ghidra plugin or as a standalone script.
   - Run experiments on Apple M1 and x86&#95;64 platforms to classify cache states (L1 vs DRAM) without timers.
   - Measure accuracy in distinguishing TLB residency and AVX wakeup throttling penalties.
3. **Benchmark agentic harness generation against traditional tools on closed-source libraries** (high effort): Assess whether Janus's structure-aware retrieval uncovers vulnerabilities in closed-source native libraries where traditional tools fail. ([#7](#paper-7))
   - Deploy Janus on a set of vendor-preinstalled apps (Vendor-20) or similar closed-source libraries.
   - Compare the number of valid harnesses generated and vulnerabilities found against Atlas++ and Poirot baselines.
   - Analyze the recursive argument construction algorithm to identify cases where composite objects fail to assemble.

## Methodology and coverage

{{< details title="How this digest was made" closed="true" >}}

**Coverage**

- arXiv submissions from October 10 to November 8, 2026 in cs.CR, cs.AR, cs.SE, cs.AI, cs.CL, cs.LG, plus 10 targeted topic searches. 12,477 unique papers were collected.
- Papers in the security-focused categories are always considered; papers from the large machine-learning categories are considered only if a keyword filter matches. Relevant papers filed elsewhere can be missed.

**Selection, ranking and scoring**

- **Quick relevance check:** 3,557 abstracts; the best 300 went on to detailed screening.
- **Detailed screening:** 300 abstracts were summarised and scored on the rubric.
- **Ranking:** the model compared papers about ten at a time (87 comparisons) using their abstract summaries. That order picks the papers in this digest and sets their rank.
- **Score:** out of 100 (topic alignment 30, applicability 25, cross-domain relevance 15, novelty 15, reproducibility 15). The model rates each part; the total and the label (Critical ≥ 85, High ≥ 70, Medium ≥ 50, Low ≥ 40) are computed in code. Papers with no security or reverse-engineering connection are capped below High. A paper whose PDF was analyzed is re-scored from the full text, which is why scores can disagree with the rank.

**Full-text analysis and verification**

- The top 15 papers' PDFs were analyzed, up to about 160k characters of text each; the rest of a longer paper was not read.
- Every number quoted under *Key results* appears in the paper's PDF; results whose numbers could not be found were dropped. Each result's page reference points to the page where its numbers appear.
- Claims marked *demonstrated* cite pages in the paper; claims without a valid page reference are shown as *claimed, not demonstrated*.
- GitHub links are checked to exist. A repository counts as the paper's code only if its name matches the paper or the paper presents it as its own; other links are listed as related tools and projects.
- **Annotated PDFs:** the model reads every page of each selected paper and highlights key aspects (yellow), win conditions, meaning how success is defined and measured (green), and interesting points (blue), with a comment on each. A highlight is placed only where the quoted text is found on the page; the paper text itself is unchanged.
- Corrections made after checking a paper by hand are listed under *Editorial correction* in that paper's details. Synthesis statements are published only if every result they quote appears in a cited paper.
- **Editorial correction to the synthesis:** CyberBinGym highlight: exploitation is hard in general, not only under hardening (Codex 88% / 20%, Claude 85% / 6%, Kimi 64% / 0%, page 6).
- **Editorial correction to the synthesis:** VulDec highlight: 'proves' overstated a statistical finding; changed to 'finds'.
- **Editorial correction to the synthesis:** Decompilation comparison: neither paper states the assumption that was attributed to them; rewritten as an interpretation of the two cited papers.
- **Editorial correction to the synthesis:** Hybrid-evidence trend: reworded an overstated, loaded phrase.
- **Editorial correction to the synthesis:** Architecture trend: VulDec covers x86 and ARM only, not RISC-V; the architectures are now stated per paper and the unsupported 'must generalize' conclusion was removed.
- **Editorial correction to the synthesis:** CyberBinGym takeaway: removed advice the paper does not support.
- **Editorial correction to the synthesis:** SEMPRE takeaway: 'essential' overstated the evidence; changed to 'helps with'.
- **Editorial correction to the synthesis:** Janus takeaway: replaced a vague claim with the paper's own result (6 previously unknown vulnerabilities).
- **Editorial correction to the synthesis:** Dropped the 'graph-based analysis infrastructure' grouping: an exemplar retrieval database (ATLAS) and field-dependency modelling (SEMPRE) are not graph-based analysis infrastructure.
- **Editorial correction to the synthesis:** Agentic-orchestration trend: 'demonstrate ... insufficient ... required' overstated what four papers show; restated as an interpretation.

**Limitations**

- The analysis is done by a small local model (`qwen3.5:9b` through Ollama), not by domain experts. Summaries can miss context or overstate results.
- Ranking uses abstract-level summaries and is noisy below the first few places; a strong paper can be missed.
- A number appearing in the PDF confirms it was reported, not that the model interpreted it correctly.
- Nothing here is independent peer review. Check the original paper before relying on any finding.

{{< /details >}}
