// ============================================
// 🔍 SCRIPT DE DIAGNÓSTICO - CÓDIGO IBGE
// ============================================
// Cole este script no Console do Chrome (F12)
// quando estiver na tela de edição do MDF-e

console.log('🔍 === INICIANDO DIAGNÓSTICO ===');

// 1. Verificar dados do emitente carregado
const verificarEmitente = () => {
  console.log('\n📦 1. Verificando dados das entidades carregadas...');

  // Tentar acessar o estado React (pode variar dependendo da versão)
  const reactRoot = document.querySelector('#root');
  if (!reactRoot) {
    console.error('❌ Root element não encontrado');
    return;
  }

  // Buscar componentes React
  const reactFiber = reactRoot._reactRootContainer?._internalRoot?.current;
  console.log('React Fiber:', reactFiber);
};

// 2. Interceptar chamadas de API
const interceptarAPI = () => {
  console.log('\n📡 2. Interceptando chamadas de API...');

  const originalFetch = window.fetch;
  window.fetch = async (...args) => {
    const url = args[0];

    if (typeof url === 'string' && url.includes('/entities/wizard')) {
      console.log('🌐 Chamada API detectada:', url);

      const response = await originalFetch(...args);
      const clonedResponse = response.clone();

      try {
        const data = await clonedResponse.json();
        console.log('📥 RESPOSTA DA API /entities/wizard:', JSON.stringify(data, null, 2));

        if (data.data?.emitentes) {
          console.log('\n🏢 EMITENTES CARREGADOS:');
          data.data.emitentes.forEach((emitente, index) => {
            console.log(`\n  Emitente ${index + 1}:`, {
              id: emitente.id,
              label: emitente.label || '❌ VAZIO',
              codMunicipio: emitente.codMunicipio || '❌ ZERO',
              municipio: emitente.municipio,
              uf: emitente.uf
            });

            if (!emitente.label) {
              console.error('❌ PROBLEMA: Label está vazio!');
            }
            if (!emitente.codMunicipio || emitente.codMunicipio === 0) {
              console.error('❌ PROBLEMA: Código IBGE está zerado!');
            }
          });
        }
      } catch (error) {
        console.error('Erro ao parsear resposta:', error);
      }

      return response;
    }

    return originalFetch(...args);
  };

  console.log('✅ Interceptor instalado! Recarregue a página ou navegue para o formulário MDF-e.');
};

// 3. Verificar localStorage
const verificarLocalStorage = () => {
  console.log('\n💾 3. Verificando localStorage...');

  for (let i = 0; i < localStorage.length; i++) {
    const key = localStorage.key(i);
    if (key && (key.includes('emitente') || key.includes('mdfe'))) {
      console.log(`  ${key}:`, localStorage.getItem(key));
    }
  }
};

// 4. Teste direto na API
const testarAPIDiretamente = async () => {
  console.log('\n🧪 4. Testando API diretamente...');

  const API_URL = 'https://localhost:5001/api';

  try {
    console.log('Chamando:', `${API_URL}/entities/wizard`);
    const response = await fetch(`${API_URL}/entities/wizard`);
    const data = await response.json();

    console.log('📦 RESPOSTA COMPLETA:', JSON.stringify(data, null, 2));

    if (data.data?.emitentes) {
      console.log(`\n✅ Total de emitentes: ${data.data.emitentes.length}`);

      data.data.emitentes.forEach((emitente, index) => {
        const problemas = [];

        if (!emitente.label || emitente.label === '') {
          problemas.push('Label vazio');
        }
        if (!emitente.codMunicipio || emitente.codMunicipio === 0) {
          problemas.push('Código IBGE zerado');
        }

        if (problemas.length > 0) {
          console.error(`\n❌ Emitente ${index + 1} - PROBLEMAS:`, {
            id: emitente.id,
            razaoSocial: emitente.razaoSocial,
            label: emitente.label,
            codMunicipio: emitente.codMunicipio,
            municipio: emitente.municipio,
            uf: emitente.uf,
            problemas
          });
        } else {
          console.log(`\n✅ Emitente ${index + 1} - OK:`, {
            id: emitente.id,
            label: emitente.label,
            codMunicipio: emitente.codMunicipio
          });
        }
      });
    }
  } catch (error) {
    console.error('❌ Erro ao chamar API:', error);
  }
};

// 5. Executar tudo
const executarDiagnostico = async () => {
  console.clear();
  console.log('🔍 === DIAGNÓSTICO COMPLETO ===\n');

  verificarEmitente();
  interceptarAPI();
  verificarLocalStorage();
  await testarAPIDiretamente();

  console.log('\n✅ === DIAGNÓSTICO CONCLUÍDO ===');
  console.log('\n💡 PRÓXIMOS PASSOS:');
  console.log('1. Analise os resultados acima');
  console.log('2. Se houver "Label vazio" ou "Código IBGE zerado", o problema está no backend');
  console.log('3. Copie toda a saída e envie para análise');
};

// Executar
executarDiagnostico();

// Exportar funções para uso manual
window.diagnostico = {
  verificarEmitente,
  interceptarAPI,
  verificarLocalStorage,
  testarAPIDiretamente,
  executar: executarDiagnostico
};

console.log('\n💡 TIP: Use window.diagnostico.executar() para rodar novamente');
