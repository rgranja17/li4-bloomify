#let db_table(name, content) = figure(
  table(
    columns: (auto, auto, 3fr),
    inset: 9pt,
    align: center + horizon,
    stroke: 0.8pt,
    
    // Linha do título
    table.cell(colspan: 3, fill: blue.lighten(15%))[*#name*],
    
    // Cabeçalhos da tabela
    table.cell(fill: blue.lighten(40%))[*Campo*],
    table.cell(fill: blue.lighten(40%))[*Tipo*],
    table.cell(fill: blue.lighten(40%))[*Descrição*],
    
    ..content.map(row => (
      table.cell(fill: blue.lighten(50%))[*#row.at(0)*], // Primeira coluna em bold e com fundo azul claro
      table.cell()[#row.at(1)],
      table.cell()[#row.at(2)]
    )).flatten()
  ),
  kind: "sql-table",
  supplement: "Tabela SQL",
  caption: name
)

#let use_case_table(name, actor, desc, pre_cond, pos_cond, flows) = figure(
  table(
    rows: (30pt, auto),
    columns: (25%, 1fr),
    inset: 5pt,
    align: center + horizon,
    stroke: 0.7pt,
    
    table.cell(colspan: 2, fill: gray.lighten(30%))[*#name*],

    table.cell(fill: gray.lighten(80%))[*Ator*], actor,
    table.cell(fill: gray.lighten(80%))[*Descrição*], desc,
    table.cell(fill: gray.lighten(80%))[*Pré-Condição*], pre_cond,
    table.cell(fill: gray.lighten(80%))[*Pós-Condição*], pos_cond,
    
    // Linha em branco para separação
    table.cell(colspan: 2, fill: gray.lighten(30%))[],

    // Fluxos
    ..flows.map(flow => {
      let flow_name = flow.at(0)
      let steps = flow.slice(1)
      (
        table.cell(rowspan: steps.len(), fill: gray.lighten(80%))[*#flow_name*],
        ..steps.map(step => table.cell(colspan: 1)[#step])
      )
    }).flatten()
  ),
  kind: "use-case",
  supplement: "Tabela Caso de Uso",
  caption: name
)

#let rerender(selector) = locate(loc => query(selector, loc).first())

#let mockup(name, caption: [], width: 100%) = figure((image("images/mockups/" + name, width: width)), caption: caption, kind: "mockup", supplement: [Esboço])


