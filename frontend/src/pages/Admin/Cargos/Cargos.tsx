import React, { useState, useEffect } from 'react';
import { ConfirmDeleteModal } from '../../../components/UI/Modal/ConfirmDeleteModal';
import { cargosService, Cargo, CargoCreateRequest, CargoUpdateRequest } from '../../../services/cargosService';
import { useAuth } from '../../../contexts/AuthContext';
import Icon from '../../../components/UI/Icon';

export function Cargos() {
  const { user } = useAuth();
  const [cargos, setCargos] = useState<Cargo[]>([]);
  const [carregando, setCarregando] = useState(false);
  const [filtro, setFiltro] = useState('');

  // Estados para modais
  const [modalVisualizacao, setModalVisualizacao] = useState(false);
  const [modalEdicao, setModalEdicao] = useState(false);
  const [cargoSelecionado, setCargoSelecionado] = useState<Cargo | null>(null);
  const [dadosFormulario, setDadosFormulario] = useState<Partial<CargoUpdateRequest>>({});
  const [salvando, setSalvando] = useState(false);

  // Estados do modal de exclusão
  const [modalExclusao, setModalExclusao] = useState(false);
  const [cargoExclusao, setCargoExclusao] = useState<Cargo | null>(null);
  const [excludindo, setExcluindo] = useState(false);

  // Verificar se usuário é Programador
  const isProgramador = user?.cargoNome === 'Programador';

  useEffect(() => {
    carregarCargos();
  }, []);

  const carregarCargos = async () => {
    setCarregando(true);
    try {
      const data = await cargosService.listarCargos();
      setCargos(data);
    } catch (error) {
      console.error('Erro ao carregar cargos:', error);
    } finally {
      setCarregando(false);
    }
  };

  const cargosFiltrados = cargos.filter(cargo =>
    cargo.nome.toLowerCase().includes(filtro.toLowerCase()) ||
    cargo.descricao?.toLowerCase().includes(filtro.toLowerCase())
  );

  const abrirModalVisualizacao = (cargo: Cargo) => {
    setCargoSelecionado(cargo);
    setModalVisualizacao(true);
  };

  const abrirModalEdicao = (cargo?: Cargo) => {
    if (cargo) {
      setCargoSelecionado(cargo);
      setDadosFormulario({
        nome: cargo.nome,
        descricao: cargo.descricao,
        ativo: cargo.ativo
      });
    } else {
      setCargoSelecionado(null);
      setDadosFormulario({
        nome: '',
        descricao: '',
        ativo: true
      });
    }
    setModalEdicao(true);
  };

  const fecharModais = () => {
    setModalVisualizacao(false);
    setModalEdicao(false);
    setCargoSelecionado(null);
    setDadosFormulario({});
  };

  const salvarCargo = async () => {
    setSalvando(true);
    try {
      if (cargoSelecionado?.id) {
        // Atualizar
        await cargosService.atualizarCargo(cargoSelecionado.id, {
          nome: dadosFormulario.nome!,
          descricao: dadosFormulario.descricao,
          ativo: dadosFormulario.ativo!
        });
      } else {
        // Criar
        await cargosService.criarCargo({
          nome: dadosFormulario.nome!,
          descricao: dadosFormulario.descricao
        });
      }

      fecharModais();
      carregarCargos();
    } catch (error: any) {
      alert(`Erro ao salvar cargo: ${error.message}`);
    } finally {
      setSalvando(false);
    }
  };

  const abrirModalExclusao = (cargo: Cargo) => {
    setCargoExclusao(cargo);
    setModalExclusao(true);
  };

  const fecharModalExclusao = () => {
    setModalExclusao(false);
    setCargoExclusao(null);
    setExcluindo(false);
  };

  const confirmarExclusao = async () => {
    if (!cargoExclusao?.id) return;

    try {
      setExcluindo(true);
      await cargosService.excluirCargo(cargoExclusao.id);
      fecharModalExclusao();
      carregarCargos();
    } catch (error: any) {
      alert(`Erro ao excluir cargo: ${error.message}`);
      setExcluindo(false);
    }
  };

  const atualizarCampo = (campo: keyof CargoUpdateRequest, valor: any) => {
    setDadosFormulario(prev => ({
      ...prev,
      [campo]: valor
    }));
  };

  if (!isProgramador) {
    return (
      <div className="max-w-7xl mx-auto px-6 py-8">
        <div className="text-center py-16">
          <Icon name="lock" className="text-gray-400 mx-auto mb-4" size="lg" />
          <h3 className="text-lg font-medium text-gray-900 mb-2">Acesso Restrito</h3>
          <p className="text-gray-500">
            Apenas usuários com cargo 'Programador' podem gerenciar cargos.
          </p>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-7xl mx-auto px-6 py-8">
      <div className="flex items-center justify-between mb-8">
        <h1 className="text-3xl font-bold text-text-primary flex items-center gap-3">
          <Icon name="users" className="text-primary" />
          Cargos
        </h1>
        <button
          className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors duration-200 flex items-center gap-2"
          onClick={() => abrirModalEdicao()}
        >
          <Icon name="plus" />
          Novo Cargo
        </button>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary p-6 mb-6">
        <div className="flex items-center gap-4">
          <div className="flex-1">
            <label className="block text-sm font-medium text-text-primary mb-2">Buscar</label>
            <input
              type="text"
              className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
              placeholder="Buscar por nome ou descrição..."
              value={filtro}
              onChange={(e) => setFiltro(e.target.value)}
            />
          </div>
          <button
            className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-tertiary transition-colors duration-200 flex items-center gap-2"
            onClick={() => setFiltro('')}
          >
            <Icon name="times" />
            Limpar
          </button>
        </div>
      </div>

      <div className="bg-bg-surface rounded-xl border border-border-primary shadow-sm">
        {carregando ? (
          <div className="flex items-center justify-center py-16">
            <div className="flex items-center gap-4">
              <div className="w-8 h-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
              <span className="text-text-secondary">Carregando cargos...</span>
            </div>
          </div>
        ) : cargosFiltrados.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-16 px-6">
            <Icon name="briefcase" className="text-gray-400 mx-auto mb-4" size="lg" />
            <h3 className="text-lg font-medium text-gray-900 mb-2">Nenhum cargo encontrado</h3>
            <p className="text-gray-500 mb-4">
              {filtro ? 'Nenhum cargo corresponde aos critérios de busca.' : 'Adicione um novo cargo para começar.'}
            </p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <div className="grid grid-cols-5 gap-4 p-4 bg-bg-tertiary border-b border-border-primary font-semibold text-text-primary">
              <div>Nome</div>
              <div>Descrição</div>
              <div>Usuários</div>
              <div>Status</div>
              <div>Ações</div>
            </div>
            {cargosFiltrados.map((cargo) => (
              <div key={cargo.id} className="grid grid-cols-5 gap-4 p-4 border-b border-border-primary hover:bg-bg-tertiary transition-colors duration-200">
                <div>
                  <strong className="text-text-primary">{cargo.nome}</strong>
                </div>
                <div>
                  <span className="text-text-secondary">
                    {cargo.descricao || '-'}
                  </span>
                </div>
                <div>
                  <span className="px-2 py-1 bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-300 rounded text-xs font-medium">
                    {cargo.quantidadeUsuarios} usuário(s)
                  </span>
                </div>
                <div>
                  <span className={`px-2 py-1 rounded-full text-xs font-medium ${
                    cargo.ativo
                      ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                      : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                  }`}>
                    {cargo.ativo ? 'Ativo' : 'Inativo'}
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <button
                    className="p-2 text-blue-600 hover:bg-blue-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalVisualizacao(cargo)}
                    title="Visualizar"
                  >
                    <Icon name="eye" size="sm" />
                  </button>
                  <button
                    className="p-2 text-amber-600 hover:bg-amber-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalEdicao(cargo)}
                    title="Editar"
                  >
                    <Icon name="edit" size="sm" />
                  </button>
                  <button
                    className="p-2 text-red-600 hover:bg-red-50 rounded-lg transition-colors duration-200"
                    onClick={() => abrirModalExclusao(cargo)}
                    title="Excluir"
                    disabled={cargo.quantidadeUsuarios > 0}
                  >
                    <Icon name="trash" size="sm" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>

      {/* Modal de Visualização */}
      {modalVisualizacao && cargoSelecionado && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4" onClick={fecharModais}>
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary">Visualizar Cargo</h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModais}>&times;</button>
            </div>
            <div className="p-6 space-y-4">
              <div>
                <label className="text-sm font-medium text-text-secondary">Nome:</label>
                <p className="text-text-primary font-medium">{cargoSelecionado.nome}</p>
              </div>
              <div>
                <label className="text-sm font-medium text-text-secondary">Descrição:</label>
                <p className="text-text-primary">{cargoSelecionado.descricao || 'Não informada'}</p>
              </div>
              <div>
                <label className="text-sm font-medium text-text-secondary">Usuários vinculados:</label>
                <p className="text-text-primary">{cargoSelecionado.quantidadeUsuarios} usuário(s)</p>
              </div>
              <div>
                <label className="text-sm font-medium text-text-secondary">Status:</label>
                <span className={`inline-block px-2 py-1 rounded-full text-xs font-medium ${
                  cargoSelecionado.ativo
                    ? 'bg-green-100 text-green-800 dark:bg-green-900 dark:text-green-300'
                    : 'bg-red-100 text-red-800 dark:bg-red-900 dark:text-red-300'
                }`}>
                  {cargoSelecionado.ativo ? 'Ativo' : 'Inativo'}
                </span>
              </div>
            </div>
            <div className="flex items-center justify-end gap-4 p-6 border-t border-border-primary">
              <button className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-tertiary transition-colors duration-200" onClick={fecharModais}>
                Fechar
              </button>
              <button className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors duration-200" onClick={() => {
                setModalVisualizacao(false);
                abrirModalEdicao(cargoSelecionado);
              }}>
                Editar
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Modal de Edição/Criação */}
      {modalEdicao && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4" onClick={fecharModais}>
          <div className="bg-bg-surface rounded-xl border border-border-primary shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto" onClick={(e) => e.stopPropagation()}>
            <div className="flex items-center justify-between p-6 border-b border-border-primary">
              <h2 className="text-xl font-semibold text-text-primary">{cargoSelecionado ? 'Editar Cargo' : 'Novo Cargo'}</h2>
              <button className="text-text-tertiary hover:text-text-primary transition-colors duration-200 text-2xl" onClick={fecharModais}>&times;</button>
            </div>
            <form className="p-6" onSubmit={(e) => { e.preventDefault(); salvarCargo(); }}>
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-text-primary mb-2">Nome *</label>
                  <input
                    type="text"
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
                    value={dadosFormulario.nome || ''}
                    onChange={(e) => atualizarCampo('nome', e.target.value)}
                    required
                    maxLength={100}
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-text-primary mb-2">Descrição</label>
                  <textarea
                    className="w-full px-3 py-2 border border-border-primary rounded-lg bg-bg-surface focus:outline-none focus:ring-2 focus:ring-primary/20"
                    rows={3}
                    value={dadosFormulario.descricao || ''}
                    onChange={(e) => atualizarCampo('descricao', e.target.value)}
                    maxLength={500}
                  />
                </div>

                {cargoSelecionado && (
                  <div className="flex items-center gap-2">
                    <input
                      type="checkbox"
                      id="ativo"
                      className="w-4 h-4 text-primary bg-bg-surface border-border-primary rounded focus:ring-primary/20 focus:ring-2"
                      checked={dadosFormulario.ativo || false}
                      onChange={(e) => atualizarCampo('ativo', e.target.checked)}
                    />
                    <label htmlFor="ativo" className="text-sm font-medium text-text-primary">
                      Cargo ativo
                    </label>
                  </div>
                )}
              </div>

              <div className="flex items-center justify-end gap-4 pt-6 border-t border-border-primary mt-6">
                <button type="button" className="px-4 py-2 border border-border-primary rounded-lg bg-bg-surface text-text-primary hover:bg-bg-tertiary transition-colors duration-200" onClick={fecharModais}>
                  Cancelar
                </button>
                <button type="submit" className="px-4 py-2 bg-primary text-white rounded-lg hover:bg-primary-hover transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed" disabled={salvando}>
                  {salvando ? 'Salvando...' : 'Salvar'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Modal de Exclusão */}
      <ConfirmDeleteModal
        isOpen={modalExclusao}
        title="Excluir Cargo"
        message="Tem certeza de que deseja excluir este cargo?"
        itemName={cargoExclusao ? cargoExclusao.nome : ''}
        onConfirm={confirmarExclusao}
        onCancel={fecharModalExclusao}
        loading={excludindo}
      />
    </div>
  );
}