import React, { useState } from 'react';
import { LocalidadeSelector } from '../../Specific/LocalidadeSelector/LocalidadeSelector';
import { mdfeService } from '../../../services/mdfeService';
import { useFieldValidation } from '../../../utils/validations';

interface MDFeFormProps {
  onSuccess: () => void;
}

interface FormData {
  emitenteId: number;
  condutorId: number;
  veiculoId: number;
  ufIni: string;
  ufFim: string;
  municipioCarregamento: string;
  municipioDescarregamento: string;
  serie: number;
  numero: number;
  reboquesIds: number[];
}

export const MDFeForm: React.FC<MDFeFormProps> = ({ onSuccess }) => {
  const { validateField } = useFieldValidation('mdfe');
  const [formData, setFormData] = useState<FormData>({
    emitenteId: 0,
    condutorId: 0,
    veiculoId: 0,
    ufIni: '',
    ufFim: '',
    municipioCarregamento: '',
    municipioDescarregamento: '',
    serie: 1,
    numero: 1,
    reboquesIds: []
  });

  const [carregando, setCarregando] = useState(false);
  const [erro, setErro] = useState('');
  const [sucesso, setSucesso] = useState('');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setCarregando(true);
    setErro('');
    setSucesso('');

    try {
      // Validações detalhadas com mensagens específicas
      if (!formData.emitenteId || formData.emitenteId === 0) {
        setErro('Por favor, selecione um emitente válido. Se não há emitentes disponíveis, cadastre um emitente primeiro no sistema.');
        return;
      }

      if (!formData.condutorId || formData.condutorId === 0) {
        setErro('Por favor, selecione um condutor válido. Se não há condutores disponíveis, cadastre um condutor primeiro no sistema.');
        return;
      }

      if (!formData.veiculoId || formData.veiculoId === 0) {
        setErro('Por favor, selecione um veículo válido. Se não há veículos disponíveis, cadastre um veículo primeiro no sistema.');
        return;
      }

      if (!formData.ufIni || !formData.ufFim) {
        setErro('Estados de origem e destino são obrigatórios. Selecione os estados onde o transporte iniciará e terminará.');
        return;
      }

      if (!formData.municipioCarregamento || !formData.municipioDescarregamento) {
        setErro('Municípios de carregamento e descarregamento são obrigatórios. Selecione os municípios onde ocorrerão o carregamento e descarregamento da carga.');
        return;
      }

      if (formData.ufIni === formData.ufFim && formData.municipioCarregamento === formData.municipioDescarregamento) {
        setErro('O município de carregamento deve ser diferente do município de descarregamento para transporte interestadual ou intermunicipal.');
        return;
      }

      // Chamar API para gerar MDFe
      const response = await mdfeService.carregarINISimples({
        emitenteId: formData.emitenteId,
        condutorId: formData.condutorId,
        veiculoId: formData.veiculoId,
        ufIni: formData.ufIni,
        ufFim: formData.ufFim,
        municipioCarregamento: formData.municipioCarregamento,
        municipioDescarregamento: formData.municipioDescarregamento,
        serie: formData.serie,
        numero: formData.numero,
        reboquesIds: formData.reboquesIds
      });

      if (response.sucesso) {
        setSucesso('MDFe gerado com sucesso!');
        setTimeout(() => onSuccess(), 2000);
      } else {
        setErro(`Erro: ${response.message}`);
      }
    } catch (err) {
      setErro('Erro ao gerar MDFe. Tente novamente.');
    } finally {
      setCarregando(false);
    }
  };

  return (
    <div className="container-fluid p-4">
      <div className="d-flex align-items-center mb-4">
        <button 
          className="btn btn-outline-secondary me-3" 
          onClick={onSuccess}
          type="button"
        >
          <i className="fas fa-arrow-left me-2"></i>
          Voltar
        </button>
        <h2 className="mb-0">
          <i className="fas fa-truck text-primary me-2"></i>
          Novo MDFe
        </h2>
      </div>

      <form onSubmit={handleSubmit}>
        <div className="row">
          {/* Card de Dados Básicos */}
          <div className="col-lg-6 mb-4">
            <div className="card h-100">
              <div className="card-header bg-primary text-white">
                <h5 className="mb-0">
                  <i className="fas fa-info-circle me-2"></i>
                  Dados Básicos
                </h5>
              </div>
              <div className="card-body">
                <div className="row">
                  <div className="col-md-6 mb-3">
                    <label className="form-label">
                      <i className="fas fa-building text-info me-2"></i>
                      Emitente *
                    </label>
                    <select
                      className="form-select"
                      value={formData.emitenteId}
                      onChange={(e) => setFormData({...formData, emitenteId: parseInt(e.target.value)})}
                      required
                    >
                      <option value={0}>Selecione o emitente...</option>
                      <option value={1}>Emitente Exemplo LTDA</option>
                    </select>
                  </div>

                  <div className="col-md-6 mb-3">
                    <label className="form-label">
                      <i className="fas fa-user text-sucesso me-2"></i>
                      Condutor *
                    </label>
                    <select
                      className="form-select"
                      value={formData.condutorId}
                      onChange={(e) => setFormData({...formData, condutorId: parseInt(e.target.value)})}
                      required
                    >
                      <option value={0}>Selecione o condutor...</option>
                      <option value={1}>João Silva</option>
                    </select>
                  </div>

                  <div className="col-md-6 mb-3">
                    <label className="form-label">
                      <i className="fas fa-truck text-warning me-2"></i>
                      Veículo *
                    </label>
                    <select
                      className="form-select"
                      value={formData.veiculoId}
                      onChange={(e) => setFormData({...formData, veiculoId: parseInt(e.target.value)})}
                      required
                    >
                      <option value={0}>Selecione o veículo...</option>
                      <option value={1}>ABC-1234 - Scania</option>
                    </select>
                  </div>

                  <div className="col-md-3 mb-3">
                    <label className="form-label">
                      <i className="fas fa-hashtag text-secondary me-2"></i>
                      Série
                    </label>
                    <input
                      type="number"
                      className="form-control"
                      value={formData.serie}
                      onChange={(e) => setFormData({...formData, serie: parseInt(e.target.value) || 1})}
                      min={1}
                    />
                  </div>

                  <div className="col-md-3 mb-3">
                    <label className="form-label">
                      <i className="fas fa-sort-numeric-up text-secondary me-2"></i>
                      Número
                    </label>
                    <input
                      type="number"
                      className="form-control"
                      value={formData.numero}
                      onChange={(e) => setFormData({...formData, numero: parseInt(e.target.value) || 1})}
                      min={1}
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Card de Localidades */}
          <div className="col-lg-6 mb-4">
            <div className="card h-100">
              <div className="card-header bg-sucesso text-white">
                <h5 className="mb-0">
                  <i className="fas fa-map-marker-alt me-2"></i>
                  Localidades
                </h5>
              </div>
              <div className="card-body">
                {/* Carregamento */}
                <LocalidadeSelector
                  label="Carregamento"
                  ufValue={formData.ufIni}
                  municipioValue={formData.municipioCarregamento}
                  onUfChange={(uf) => setFormData({...formData, ufIni: uf})}
                  onMunicipioChange={(municipio) => setFormData({...formData, municipioCarregamento: municipio})}
                  required
                />

                {/* Descarregamento */}
                <LocalidadeSelector
                  label="Descarregamento"
                  ufValue={formData.ufFim}
                  municipioValue={formData.municipioDescarregamento}
                  onUfChange={(uf) => setFormData({...formData, ufFim: uf})}
                  onMunicipioChange={(municipio) => setFormData({...formData, municipioDescarregamento: municipio})}
                  required
                />
              </div>
            </div>
          </div>
        </div>

        {/* Mensagens de Feedback */}
        {erro && (
          <div className="alert alert-danger" role="alert">
            <i className="fas fa-exclamation-triangle me-2"></i>
            {erro}
          </div>
        )}

        {sucesso && (
          <div className="alert alert-sucesso" role="alert">
            <i className="fas fa-check-circle me-2"></i>
            {sucesso}
          </div>
        )}

        {/* Botões de Ação */}
        <div className="d-flex justify-content-end gap-3">
          <button
            type="button"
            className="btn btn-outline-secondary"
            onClick={onSuccess}
          >
            <i className="fas fa-times me-2"></i>
            Cancelar
          </button>
          <button
            type="submit"
            className="btn btn-primary"
            disabled={carregando}
          >
            {carregando ? (
              <>
                <i className="fas fa-spinner fa-spin me-2"></i>
                Gerando MDFe...
              </>
            ) : (
              <>
                <i className="fas fa-save me-2"></i>
                Gerar MDFe
              </>
            )}
          </button>
        </div>
      </form>
    </div>
  );
};